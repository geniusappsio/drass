DROP TABLE IF EXISTS marcas CASCADE;
CREATE TABLE marcas (
	codigo							,
	nome							VARCHAR,
	descricao						VARCHAR,
	logo_url						VARCHAR,
	ativo							BOOLEAN NOT NULL DEFAULT TRUE,
	usuario_criacao_codigo			UUID REFERENCES auth.user(id),
	usuario_edicao_codigo			UUID REFERENCES auth.user(id),
	dh_criacao						TIMESTAMP NOT NULL DEFAULT NOW(),
	dh_atualizacao					TIMESTAMP NOT NULL DEFAULT NOW()
);
COMMENT ON TABLE marcas IS 'Armazena informações das marcas de produtos disponíveis no sistema';
COMMENT ON COLUMN marcas.codigo IS 'Identificador único da marca';
COMMENT ON COLUMN marcas.nome IS 'Nome comercial da marca';
COMMENT ON COLUMN marcas.descricao IS 'Descrição ou informações adicionais sobre a marca';
COMMENT ON COLUMN marcas.logo_url IS 'URL da imagem do logotipo da marca';
COMMENT ON COLUMN marcas.ativo IS 'Indica se a marca está ativa para uso no sistema';
COMMENT ON COLUMN marcas.usuario_criacao_codigo IS 'Referência ao usuário que criou o registro';
COMMENT ON COLUMN marcas.usuario_edicao_codigo IS 'Referência ao último usuário que editou o registro';
COMMENT ON COLUMN marcas.dh_criacao IS 'Data e hora de criação do registro';
COMMENT ON COLUMN marcas.dh_atualizacao IS 'Data e hora da última atualização do registro';


DROP TABLE IF EXISTS categorias CASCADE;
CREATE TABLE categorias (
    codigo							UUID NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),
    nome 							VARCHAR NOT NULL,
    descricao 						TEXT,
    categoria_pai_codigo			UUID REFERENCES categorias(codigo),
    url_imagem                      TEXT,
    ativo 							BOOLEAN DEFAULT TRUE,
	usuario_criacao_codigo			UUID REFERENCES auth.user(id),
	usuario_edicao_codigo			UUID REFERENCES auth.user(id),
	dh_criacao						TIMESTAMP NOT NULL DEFAULT NOW(),
	dh_atualizacao					TIMESTAMP NOT NULL DEFAULT NOW()
);
COMMENT ON TABLE categorias IS 'Armazena as categorias para classificação hierárquica de produtos';
COMMENT ON COLUMN categorias.codigo IS 'Identificador único da categoria';
COMMENT ON COLUMN categorias.nome IS 'Nome da categoria';
COMMENT ON COLUMN categorias.descricao IS 'Descrição detalhada da categoria';
COMMENT ON COLUMN categorias.categoria_pai_codigo IS 'Referência à categoria pai, permitindo estrutura hierárquica';
COMMENT ON COLUMN categorias.url_imagem IS 'URL da imagem representativa da categoria';
COMMENT ON COLUMN categorias.ativo IS 'Indica se a categoria está ativa para uso no sistema';
COMMENT ON COLUMN categorias.usuario_criacao_codigo IS 'Referência ao usuário que criou o registro';
COMMENT ON COLUMN categorias.usuario_edicao_codigo IS 'Referência ao último usuário que editou o registro';
COMMENT ON COLUMN categorias.dh_criacao IS 'Data e hora de criação do registro';
COMMENT ON COLUMN categorias.dh_atualizacao IS 'Data e hora da última atualização do registro';


DROP TABLE IF EXISTS modelos CASCADE;
CREATE TABLE modelos (
    codigo 							UUID NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),
    nome 					 		VARCHAR NOT NULL,
    descricao 						TEXT,
    marca_codigo					UUID NOT NULL REFERENCES marcas(codigo),
    categoria_codigo 				UUID NOT NULL REFERENCES categorias(codigo),
    ano_lancamento 					INTEGER,
    ativo 							BOOLEAN DEFAULT TRUE,
	dh_criacao						TIMESTAMP NOT NULL DEFAULT NOW(),
	dh_atualizacao					TIMESTAMP NOT NULL DEFAULT NOW()
);
COMMENT ON TABLE modelos IS 'Armazena os modelos específicos de produtos oferecidos pelas marcas';
COMMENT ON COLUMN modelos.codigo IS 'Identificador único do modelo';
COMMENT ON COLUMN modelos.nome IS 'Nome do modelo';
COMMENT ON COLUMN modelos.descricao IS 'Descrição detalhada do modelo';
COMMENT ON COLUMN modelos.marca_codigo IS 'Referência à marca à qual o modelo pertence';
COMMENT ON COLUMN modelos.categoria_codigo IS 'Referência à categoria do modelo';
COMMENT ON COLUMN modelos.ano_lancamento IS 'Ano em que o modelo foi lançado';
COMMENT ON COLUMN modelos.ativo IS 'Indica se o modelo está ativo para uso no sistema';
COMMENT ON COLUMN modelos.dh_criacao IS 'Data e hora de criação do registro';
COMMENT ON COLUMN modelos.dh_atualizacao IS 'Data e hora da última atualização do registro';

DROP TABLE IF EXISTS cores CASCADE;
CREATE TABLE cores (
    codigo						 	UUID NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),
    nome 							VARCHAR NOT NULL,
    codigo_hex 						VARCHAR
);
COMMENT ON TABLE cores IS 'Armazena as cores disponíveis para os produtos';
COMMENT ON COLUMN cores.codigo IS 'Identificador único da cor';
COMMENT ON COLUMN cores.nome IS 'Nome da cor';
COMMENT ON COLUMN cores.codigo_hex IS 'Código hexadecimal da cor para representação visual';

DROP TABLE IF EXISTS produtos CASCADE;
CREATE TABLE produtos (
	codigo						    SERIAL NOT NULL PRIMARY KEY,
	descricao 					    VARCHAR NOT NULL,
);


-----------

DROP TABLE IF EXISTS secoes CASCADE;
CREATE TABLE secoes (
    codigo                          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    titulo                          VARCHAR(255) NOT NULL,
    exibir_titulo                   BOOLEAN NOT NULL DEFAULT FALSE,
    tipo secao_tipo                 NOT NULL,
    status                          secao_status DEFAULT 'RASCUNHO',
    ordem_exibicao                  INT NOT NULL,
    visivel                         BOOLEAN DEFAULT true,
    fonte_dados                     secao_fonte_dados NOT NULL,
    dh_agendamento_inicio           TIMESTAMP WITH TIME ZONE,
    dh_agendamento_fim              TIMESTAMP WITH TIME ZONE,
    dh_criacao                      TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    dh_atualizacao                  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    dh_publicacao                   TIMESTAMP WITH TIME ZONE,
    usuario_criacao_codigo          UUID REFERENCES auth.users(id),
    usuario_edicao_codigo           UUID REFERENCES auth.users(id)
);
COMMENT ON TABLE secoes IS 'Armazena as definições de seções (blocos de conteúdo) para exibição no site';
COMMENT ON COLUMN secoes.codigo IS 'Identificador único da seção';
COMMENT ON COLUMN secoes.titulo IS 'Título principal da seção';
COMMENT ON COLUMN secoes.exibir_titulo IS 'Indica se o título da seção deve ser exibido no frontend';
COMMENT ON COLUMN secoes.tipo IS 'Layout visual da seção (banner, carrossel, grid, etc.)';
COMMENT ON COLUMN secoes.status IS 'Estado de publicação da seção (ativo, inativo, rascunho)';
COMMENT ON COLUMN secoes.ordem_exibicao IS 'Posição da seção na página (ordem crescente)';
COMMENT ON COLUMN secoes.visivel IS 'Controle imediato de visibilidade da seção';
COMMENT ON COLUMN secoes.fonte_dados IS 'Define se o conteúdo é inserido manualmente ou gerado dinamicamente';
COMMENT ON COLUMN secoes.dh_agendamento_inicio IS 'Data e hora programadas para início da exibição automática';
COMMENT ON COLUMN secoes.dh_agendamento_fim IS 'Data e hora programadas para término da exibição automática';
COMMENT ON COLUMN secoes.dh_criacao IS 'Data e hora de criação do registro';
COMMENT ON COLUMN secoes.dh_atualizacao IS 'Data e hora da última atualização do registro';
COMMENT ON COLUMN secoes.dh_publicacao IS 'Data e hora em que a seção foi publicada pela última vez';
COMMENT ON COLUMN secoes.usuario_criacao_codigo IS 'Referência ao usuário que criou a seção';
COMMENT ON COLUMN secoes.usuario_edicao_codigo IS 'Referência ao último usuário que editou a seção';