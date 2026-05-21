\set ON_ERROR_STOP on

-- ============================================================
-- 04_transform_load_final.sql
-- Transforma/valida os dados da staging e carrega nas tabelas finais.
-- Estas tabelas finais são as consumidas pelo Apache Superset.
-- ============================================================

BEGIN;

-- ============================================================
-- LIMPEZA DAS TABELAS FINAIS
-- ============================================================

TRUNCATE TABLE
    inscricoes_uc,
    ausencias,
    alunos,
    unidades_curriculares,
    cursos,
    orcamento,
    despesas,
    colaboradores,
    projetos,
    publicacoes_ria
RESTART IDENTITY;


-- ============================================================
-- CURSOS
-- ============================================================

INSERT INTO cursos (
    curso_id,
    designacao,
    departamento,
    ects_totais,
    numero_vagas,
    numero_inscritos_atual,
    grau,
    ativo
)
SELECT DISTINCT ON (TRIM(curso_id))
    TRIM(curso_id),
    TRIM(designacao),
    TRIM(departamento),
    staging.to_int(ects_totais),
    staging.to_int(numero_vagas),
    staging.to_int(numero_inscritos_atual),
    TRIM(grau),
    staging.to_bool(ativo)
FROM staging.cursos_raw
WHERE NULLIF(TRIM(curso_id), '') IS NOT NULL
ORDER BY TRIM(curso_id);


-- ============================================================
-- UNIDADES CURRICULARES
-- ============================================================

INSERT INTO unidades_curriculares (
    uc_id,
    designacao,
    ects,
    departamento,
    ano_curricular,
    semestre,
    obrigatoria
)
SELECT DISTINCT ON (TRIM(uc_id))
    TRIM(uc_id),
    TRIM(designacao),
    staging.to_int(ects),
    TRIM(departamento),
    staging.to_int(ano_curricular),
    staging.to_int(semestre),
    staging.to_bool(obrigatoria)
FROM staging.unidades_curriculares_raw
WHERE NULLIF(TRIM(uc_id), '') IS NOT NULL
ORDER BY TRIM(uc_id);


-- ============================================================
-- ALUNOS
-- Só entram alunos cujo curso existe na tabela cursos.
-- ============================================================

INSERT INTO alunos (
    aluno_id,
    nome_completo,
    genero,
    data_nascimento,
    curso_id,
    departamento,
    ano_matricula,
    estatuto,
    email_institucional,
    nacionalidade,
    regime
)
SELECT DISTINCT ON (TRIM(a.aluno_id))
    TRIM(a.aluno_id),
    TRIM(a.nome_completo),
    TRIM(a.genero),
    staging.to_date_iso(a.data_nascimento),
    TRIM(a.curso_id),
    TRIM(a.departamento),
    staging.to_int(a.ano_matricula),
    TRIM(a.estatuto),
    LOWER(TRIM(a.email_institucional)),
    TRIM(a.nacionalidade),
    TRIM(a.regime)
FROM staging.alunos_raw a
JOIN cursos c
    ON c.curso_id = TRIM(a.curso_id)
WHERE NULLIF(TRIM(a.aluno_id), '') IS NOT NULL
ORDER BY TRIM(a.aluno_id);


-- ============================================================
-- INSCRIÇÕES EM UCs
-- Só entram inscrições cujo aluno e UC existem.
-- Também se validam notas entre 0 e 20.
-- ============================================================

INSERT INTO inscricoes_uc (
    inscricao_id,
    aluno_id,
    uc_id,
    semestre,
    ano_letivo,
    nota_final,
    resultado,
    epoca
)
SELECT DISTINCT ON (TRIM(i.inscricao_id))
    TRIM(i.inscricao_id),
    TRIM(i.aluno_id),
    TRIM(i.uc_id),
    staging.to_int(i.semestre),
    TRIM(i.ano_letivo),
    CASE
        WHEN staging.to_int(i.nota_final) BETWEEN 0 AND 20
            THEN staging.to_int(i.nota_final)
        ELSE NULL
    END AS nota_final,
    INITCAP(LOWER(TRIM(i.resultado))),
    TRIM(i.epoca)
FROM staging.inscricoes_uc_raw i
JOIN alunos a
    ON a.aluno_id = TRIM(i.aluno_id)
JOIN unidades_curriculares uc
    ON uc.uc_id = TRIM(i.uc_id)
WHERE NULLIF(TRIM(i.inscricao_id), '') IS NOT NULL
ORDER BY TRIM(i.inscricao_id);


-- ============================================================
-- ORÇAMENTO
-- Percentagem de execução limitada a valores entre 0 e 100.
-- ============================================================

INSERT INTO orcamento (
    orcamento_id,
    ano,
    departamento,
    rubrica,
    dotacao_inicial,
    dotacao_atual,
    execucao_acumulada,
    percentagem_execucao
)
SELECT DISTINCT ON (TRIM(orcamento_id))
    TRIM(orcamento_id),
    staging.to_int(ano),
    TRIM(departamento),
    TRIM(rubrica),
    staging.to_numeric(dotacao_inicial)::NUMERIC(14,2),
    staging.to_numeric(dotacao_atual)::NUMERIC(14,2),
    staging.to_numeric(execucao_acumulada)::NUMERIC(14,2),
    CASE
        WHEN staging.to_numeric(percentagem_execucao) BETWEEN 0 AND 100
            THEN staging.to_numeric(percentagem_execucao)::NUMERIC(6,2)
        ELSE NULL
    END AS percentagem_execucao
FROM staging.orcamento_raw
WHERE NULLIF(TRIM(orcamento_id), '') IS NOT NULL
ORDER BY TRIM(orcamento_id);


-- ============================================================
-- DESPESAS
-- ============================================================

INSERT INTO despesas (
    despesa_id,
    data_despesa,
    departamento,
    rubrica,
    fornecedor,
    valor,
    estado,
    centro_custo
)
SELECT DISTINCT ON (TRIM(despesa_id))
    TRIM(despesa_id),
    staging.to_date_iso(data_despesa),
    TRIM(departamento),
    TRIM(rubrica),
    TRIM(fornecedor),
    staging.to_numeric(valor)::NUMERIC(14,2),
    INITCAP(LOWER(TRIM(estado))),
    TRIM(centro_custo)
FROM staging.despesas_raw
WHERE NULLIF(TRIM(despesa_id), '') IS NOT NULL
ORDER BY TRIM(despesa_id);


-- ============================================================
-- COLABORADORES
-- ============================================================

INSERT INTO colaboradores (
    colaborador_id,
    nome_completo,
    categoria,
    departamento,
    regime,
    data_inicio_contrato,
    tipo_contrato,
    estado
)
SELECT DISTINCT ON (TRIM(colaborador_id))
    TRIM(colaborador_id),
    TRIM(nome_completo),
    TRIM(categoria),
    TRIM(departamento),
    TRIM(regime),
    staging.to_date_iso(data_inicio_contrato),
    TRIM(tipo_contrato),
    INITCAP(LOWER(TRIM(estado)))
FROM staging.colaboradores_raw
WHERE NULLIF(TRIM(colaborador_id), '') IS NOT NULL
ORDER BY TRIM(colaborador_id);


-- ============================================================
-- AUSÊNCIAS
-- Só entram ausências cujo colaborador existe.
-- ============================================================

INSERT INTO ausencias (
    ausencia_id,
    colaborador_id,
    tipo_ausencia,
    data_inicio,
    data_fim,
    duracao_dias,
    aprovada
)
SELECT DISTINCT ON (TRIM(aus.ausencia_id))
    TRIM(aus.ausencia_id),
    TRIM(aus.colaborador_id),
    TRIM(aus.tipo_ausencia),
    staging.to_date_iso(aus.data_inicio),
    staging.to_date_iso(aus.data_fim),
    staging.to_int(aus.duracao_dias),
    staging.to_bool(aus.aprovada)
FROM staging.ausencias_raw aus
JOIN colaboradores c
    ON c.colaborador_id = TRIM(aus.colaborador_id)
WHERE NULLIF(TRIM(aus.ausencia_id), '') IS NOT NULL
ORDER BY TRIM(aus.ausencia_id);


-- ============================================================
-- PROJETOS
-- ============================================================

INSERT INTO projetos (
    projeto_id,
    titulo,
    departamento_lider,
    fonte_financiamento,
    orcamento_total,
    data_inicio,
    data_fim,
    estado,
    equipa_elementos
)
SELECT DISTINCT ON (TRIM(projeto_id))
    TRIM(projeto_id),
    TRIM(titulo),
    TRIM(departamento_lider),
    TRIM(fonte_financiamento),
    staging.to_numeric(orcamento_total)::NUMERIC(14,2),
    staging.to_date_iso(data_inicio),
    staging.to_date_iso(data_fim),
    INITCAP(LOWER(TRIM(estado))),
    staging.to_int(equipa_elementos)
FROM staging.projetos_raw
WHERE NULLIF(TRIM(projeto_id), '') IS NOT NULL
ORDER BY TRIM(projeto_id);


-- ============================================================
-- PUBLICAÇÕES RIA
-- ============================================================

INSERT INTO publicacoes_ria (
    ria_id,
    titulo,
    tipo_publicacao,
    departamento,
    data_publicacao,
    ano_publicacao,
    autores_numero,
    downloads,
    citacoes,
    licenca_acesso
)
SELECT DISTINCT ON (TRIM(ria_id))
    TRIM(ria_id),
    TRIM(titulo),
    TRIM(tipo_publicacao),
    TRIM(departamento),
    staging.to_date_iso(data_publicacao),
    staging.to_int(ano_publicacao),
    staging.to_int(autores_numero),
    staging.to_int(downloads),
    staging.to_int(citacoes),
    TRIM(licenca_acesso)
FROM staging.publicacoes_ria_raw
WHERE NULLIF(TRIM(ria_id), '') IS NOT NULL
ORDER BY TRIM(ria_id);


-- ============================================================
-- ATUALIZAÇÃO DE ESTATÍSTICAS
-- ============================================================

ANALYZE cursos;
ANALYZE alunos;
ANALYZE unidades_curriculares;
ANALYZE inscricoes_uc;
ANALYZE orcamento;
ANALYZE despesas;
ANALYZE colaboradores;
ANALYZE ausencias;
ANALYZE projetos;
ANALYZE publicacoes_ria;

COMMIT;