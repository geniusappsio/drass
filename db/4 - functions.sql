-- FUNÇÃO PARA ATUALIZAR AS DH_ATUALIZAÇÃO DAS TABELAS.

DROP FUNCTION IF EXISTS public.atualizar_coluna_dh_atualizacao;
CREATE OR REPLACE FUNCTION public.atualizar_coluna_dh_atualizacao()
RETURNS TRIGGER AS $$
BEGIN
    NEW.dh_atualizacao = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION public.atualizar_coluna_dh_atualizacao IS 'Função para atualizar a coluna dh_atualizacao com o horário atual.';

DROP FUNCTION IF EXISTS public.criar_triggers_dh_atualizacao CASCADE;
CREATE OR REPLACE FUNCTION criar_triggers_dh_atualizacao() 
RETURNS void AS $$
DECLARE
    table_record RECORD;
BEGIN
    FOR table_record IN
        SELECT t.table_name, t.table_schema
        FROM information_schema.tables t
        WHERE t.table_schema IN ('public', 'meta')
        AND EXISTS (
            SELECT 1 FROM information_schema.columns
            WHERE table_schema = t.table_schema
            AND table_name = t.table_name
            AND column_name = 'dh_atualizacao'
        )
        AND NOT EXISTS (
            SELECT 1 FROM information_schema.triggers
            WHERE event_object_schema = t.table_schema
            AND event_object_table = t.table_name
            AND trigger_name = format('atualizar_%I_dh_atualizacao', t.table_name)
        )
    LOOP
        EXECUTE format('CREATE TRIGGER atualizar_%I_dh_atualizacao BEFORE UPDATE ON %I.%I FOR EACH ROW EXECUTE FUNCTION atualizar_coluna_dh_atualizacao();', table_record.table_name, table_record.table_schema, table_record.table_name);
    END LOOP;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION criar_triggers_dh_atualizacao IS 'Função para criar gatilhos de atualização nas tabelas que possuem a coluna dh_atualizacao.';

-- Auto-execução da função
DO $$
BEGIN
    PERFORM criar_triggers_dh_atualizacao();
END $$;

-----------------------

DROP FUNCTION IF EXISTS public.atualizar_visibilidade_secoes;
-- Crie a função para atualizar estados de visibilidade
CREATE OR REPLACE FUNCTION atualizar_visibilidade_secoes()
RETURNS void AS $$
DECLARE
    momento_atual TIMESTAMP WITH TIME ZONE := NOW();
    secao_record RECORD;
    mudou_visibilidade BOOLEAN;
BEGIN
    -- Loop através de todas as seções ativas
    FOR secao_record IN 
        SELECT codigo, titulo, visivel, dh_agendamento_inicio, dh_agendamento_fim 
        FROM secoes 
        WHERE status = 'ATIVO'
    LOOP
        mudou_visibilidade := FALSE;
        
        -- Verificar se a seção deve estar visível agora
        IF (secao_record.dh_agendamento_inicio IS NOT NULL AND secao_record.dh_agendamento_inicio <= momento_atual) THEN
            -- Dentro do período de visibilidade
            IF (secao_record.dh_agendamento_fim IS NULL OR secao_record.dh_agendamento_fim > momento_atual) THEN
                IF (NOT secao_record.visivel) THEN
                    -- Tornar visível se estava invisível
                    UPDATE secoes SET visivel = TRUE, dh_atualizacao = momento_atual WHERE codigo = secao_record.codigo;
                    mudou_visibilidade := TRUE;
                    
                    -- Registrar no histórico a ativação automática
                    INSERT INTO secao_historico (secao_codigo, acao, dados_novos)
                    VALUES (secao_record.codigo, 'PUBLICADO', jsonb_build_object('motivo', 'Ativação automática por agendamento', 'horario', momento_atual));
                END IF;
            ELSIF (secao_record.visivel) THEN
                -- Período encerrado, desativar se estava visível
                UPDATE secoes SET visivel = FALSE, dh_atualizacao = momento_atual WHERE codigo = secao_record.codigo;
                mudou_visibilidade := TRUE;
                
                -- Registrar no histórico a desativação automática
                INSERT INTO secao_historico (secao_codigo, acao, dados_novos)
                VALUES (secao_record.codigo, 'DESPUBLICADO', jsonb_build_object('motivo', 'Desativação automática por fim de agendamento', 'horario', momento_atual));
            END IF;
        ELSIF (secao_record.visivel AND secao_record.dh_agendamento_inicio > momento_atual) THEN
            -- Seção está visível mas ainda não chegou no período
            UPDATE secoes SET visivel = FALSE, dh_atualizacao = momento_atual WHERE codigo = secao_record.codigo;
            mudou_visibilidade := TRUE;
            
            -- Registrar no histórico
            INSERT INTO secao_historico (secao_codigo, acao, dados_novos)
            VALUES (secao_record.codigo, 'DESPUBLICADO', jsonb_build_object('motivo', 'Desativação automática - data de início ainda não alcançada', 'horario', momento_atual));
        END IF;
        
        -- Log para monitoramento (opcional)
        IF mudou_visibilidade THEN
            RAISE NOTICE 'Alterada visibilidade da seção %: %', secao_record.codigo, secao_record.titulo;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;