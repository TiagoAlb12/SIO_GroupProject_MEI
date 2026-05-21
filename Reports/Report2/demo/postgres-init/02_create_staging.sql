\set ON_ERROR_STOP on

-- ============================================================
-- 02_create_staging.sql
-- Cria a camada staging, funções auxiliares e tabelas raw.
-- ============================================================

CREATE SCHEMA IF NOT EXISTS staging;


-- ============================================================
-- FUNÇÕES AUXILIARES DE CONVERSÃO
-- ============================================================

CREATE OR REPLACE FUNCTION staging.to_int(value TEXT)
RETURNS INTEGER
LANGUAGE plpgsql
IMMUTABLE
AS $$
BEGIN
    IF value IS NULL OR BTRIM(value) = '' THEN
        RETURN NULL;
    END IF;

    RETURN BTRIM(value)::INTEGER;

EXCEPTION WHEN OTHERS THEN
    RETURN NULL;
END;
$$;


CREATE OR REPLACE FUNCTION staging.to_numeric(value TEXT)
RETURNS NUMERIC
LANGUAGE plpgsql
IMMUTABLE
AS $$
BEGIN
    IF value IS NULL OR BTRIM(value) = '' THEN
        RETURN NULL;
    END IF;

    RETURN REPLACE(BTRIM(value), ',', '.')::NUMERIC;

EXCEPTION WHEN OTHERS THEN
    RETURN NULL;
END;
$$;


CREATE OR REPLACE FUNCTION staging.to_date_iso(value TEXT)
RETURNS DATE
LANGUAGE plpgsql
IMMUTABLE
AS $$
BEGIN
    IF value IS NULL OR BTRIM(value) = '' THEN
        RETURN NULL;
    END IF;

    RETURN BTRIM(value)::DATE;

EXCEPTION WHEN OTHERS THEN
    RETURN NULL;
END;
$$;


CREATE OR REPLACE FUNCTION staging.to_bool(value TEXT)
RETURNS BOOLEAN
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
    normalized TEXT;
BEGIN
    IF value IS NULL OR BTRIM(value) = '' THEN
        RETURN NULL;
    END IF;

    normalized := LOWER(BTRIM(value));

    IF normalized IN ('true', 't', '1', 'yes', 'y', 'sim', 's') THEN
        RETURN TRUE;
    END IF;

    IF normalized IN ('false', 'f', '0', 'no', 'n', 'nao', 'não') THEN
        RETURN FALSE;
    END IF;

    RETURN NULL;
END;
$$;


-- ============================================================
-- LIMPEZA DAS TABELAS RAW
-- ============================================================

DROP TABLE IF EXISTS staging.cursos_raw;
DROP TABLE IF EXISTS staging.alunos_raw;
DROP TABLE IF EXISTS staging.unidades_curriculares_raw;
DROP TABLE IF EXISTS staging.inscricoes_uc_raw;
DROP TABLE IF EXISTS staging.orcamento_raw;
DROP TABLE IF EXISTS staging.despesas_raw;
DROP TABLE IF EXISTS staging.colaboradores_raw;
DROP TABLE IF EXISTS staging.ausencias_raw;
DROP TABLE IF EXISTS staging.projetos_raw;
DROP TABLE IF EXISTS staging.publicacoes_ria_raw;


-- ============================================================
-- CRIAÇÃO DAS TABELAS RAW
-- Todas as colunas ficam como TEXT para representar dados brutos.
-- ============================================================

CREATE TABLE staging.cursos_raw (
    curso_id TEXT,
    designacao TEXT,
    departamento TEXT,
    ects_totais TEXT,
    numero_vagas TEXT,
    numero_inscritos_atual TEXT,
    grau TEXT,
    ativo TEXT
);

CREATE TABLE staging.alunos_raw (
    aluno_id TEXT,
    nome_completo TEXT,
    genero TEXT,
    data_nascimento TEXT,
    curso_id TEXT,
    departamento TEXT,
    ano_matricula TEXT,
    estatuto TEXT,
    email_institucional TEXT,
    nacionalidade TEXT,
    regime TEXT
);

CREATE TABLE staging.unidades_curriculares_raw (
    uc_id TEXT,
    designacao TEXT,
    ects TEXT,
    departamento TEXT,
    ano_curricular TEXT,
    semestre TEXT,
    obrigatoria TEXT
);

CREATE TABLE staging.inscricoes_uc_raw (
    inscricao_id TEXT,
    aluno_id TEXT,
    uc_id TEXT,
    semestre TEXT,
    ano_letivo TEXT,
    nota_final TEXT,
    resultado TEXT,
    epoca TEXT
);

CREATE TABLE staging.orcamento_raw (
    orcamento_id TEXT,
    ano TEXT,
    departamento TEXT,
    rubrica TEXT,
    dotacao_inicial TEXT,
    dotacao_atual TEXT,
    execucao_acumulada TEXT,
    percentagem_execucao TEXT
);

CREATE TABLE staging.despesas_raw (
    despesa_id TEXT,
    data_despesa TEXT,
    departamento TEXT,
    rubrica TEXT,
    fornecedor TEXT,
    valor TEXT,
    estado TEXT,
    centro_custo TEXT
);

CREATE TABLE staging.colaboradores_raw (
    colaborador_id TEXT,
    nome_completo TEXT,
    categoria TEXT,
    departamento TEXT,
    regime TEXT,
    data_inicio_contrato TEXT,
    tipo_contrato TEXT,
    estado TEXT
);

CREATE TABLE staging.ausencias_raw (
    ausencia_id TEXT,
    colaborador_id TEXT,
    tipo_ausencia TEXT,
    data_inicio TEXT,
    data_fim TEXT,
    duracao_dias TEXT,
    aprovada TEXT
);

CREATE TABLE staging.projetos_raw (
    projeto_id TEXT,
    titulo TEXT,
    departamento_lider TEXT,
    fonte_financiamento TEXT,
    orcamento_total TEXT,
    data_inicio TEXT,
    data_fim TEXT,
    estado TEXT,
    equipa_elementos TEXT
);

CREATE TABLE staging.publicacoes_ria_raw (
    ria_id TEXT,
    titulo TEXT,
    tipo_publicacao TEXT,
    departamento TEXT,
    data_publicacao TEXT,
    ano_publicacao TEXT,
    autores_numero TEXT,
    downloads TEXT,
    citacoes TEXT,
    licenca_acesso TEXT
);