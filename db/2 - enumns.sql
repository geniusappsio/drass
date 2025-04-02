DROP TYPE IF EXISTS secao_tipo;
CREATE TYPE secao_tipo AS ENUM ('BANNER', 'CARROSSEL', 'GRID', 'CARDS', 'STORIES');
COMMENT ON TYPE secao_tipo IS 'Tipos de layout de seção disponíveis no sistema';

DROP TYPE IF EXISTS secao_status;
CREATE TYPE secao_status AS ENUM ('ATIVO', 'INATIVO', 'RASCUNHO');
COMMENT ON TYPE secao_status IS 'Estados possíveis de publicação de uma seção';

DROP TYPE IF EXISTS secao_fonte_dados;
CREATE TYPE secao_fonte_dados AS ENUM ('MANUAL', 'DINAMICA');
COMMENT ON TYPE secao_fonte_dados IS 'Define se os dados da seção são inseridos manualmente ou gerados dinamicamente';

DROP TYPE IF EXISTS secao_consulta_tipo;
CREATE TYPE secao_consulta_tipo AS ENUM ('MAIS_VENDIDOS', 'LANCAMENTOS', 'PROMOCOES', 'POR_MARCA', 'POR_CATEGORIA', 'PERSONALIZADA');
COMMENT ON TYPE secao_consulta_tipo IS 'Estratégias de consulta para seções com fonte de dados dinâmica';

DROP TYPE IF EXISTS secao_estilo_tamanho;
CREATE TYPE secao_estilo_tamanho AS ENUM ('PEQUENO', 'MEDIO', 'GRANDE', 'COMPLETO');
COMMENT ON TYPE secao_estilo_tamanho IS 'Opções de dimensionamento para seções';

DROP TYPE IF EXISTS secao_estilo_arredondamento;
CREATE TYPE secao_estilo_arredondamento AS ENUM ('NENHUM', 'LEVE', 'MEDIO', 'COMPLETO');
COMMENT ON TYPE secao_estilo_arredondamento IS 'Níveis de arredondamento para componentes visuais';

DROP TYPE IF EXISTS secao_imagem_tipo;
CREATE TYPE secao_imagem_tipo AS ENUM ('BANNER', 'THUMBNAIL', 'ICONE', 'STORY', 'PRODUTO');
COMMENT ON TYPE secao_imagem_tipo IS 'Categorias de imagens usadas em seções';

DROP TYPE IF EXISTS secao_historico_acao;
CREATE TYPE secao_historico_acao AS ENUM ('CRIADO', 'ATUALIZADO', 'PUBLICADO', 'DESPUBLICADO', 'EXCLUIDO');
COMMENT ON TYPE secao_historico_acao IS 'Tipos de operações registradas no histórico de seções';