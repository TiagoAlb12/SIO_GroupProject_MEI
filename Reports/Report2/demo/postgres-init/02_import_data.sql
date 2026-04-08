COPY cursos (
    curso_id,
    designacao,
    departamento,
    ects_totais,
    numero_vagas,
    numero_inscritos_atual,
    grau,
    ativo
)
FROM '/data/cursos.csv'
DELIMITER ','
CSV HEADER;

COPY alunos (
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
FROM '/data/alunos.csv'
DELIMITER ','
CSV HEADER;

COPY unidades_curriculares (
    uc_id,
    designacao,
    ects,
    departamento,
    ano_curricular,
    semestre,
    obrigatoria
)
FROM '/data/unidades_curriculares.csv'
DELIMITER ','
CSV HEADER;

COPY inscricoes_uc (
    inscricao_id,
    aluno_id,
    uc_id,
    semestre,
    ano_letivo,
    nota_final,
    resultado,
    epoca
)
FROM '/data/inscricoes_uc.csv'
DELIMITER ','
CSV HEADER;

COPY orcamento (
    orcamento_id,
    ano,
    departamento,
    rubrica,
    dotacao_inicial,
    dotacao_atual,
    execucao_acumulada,
    percentagem_execucao
)
FROM '/data/orcamento.csv'
DELIMITER ','
CSV HEADER;

COPY despesas (
    despesa_id,
    data_despesa,
    departamento,
    rubrica,
    fornecedor,
    valor,
    estado,
    centro_custo
)
FROM '/data/despesas.csv'
DELIMITER ','
CSV HEADER;

COPY colaboradores (
    colaborador_id,
    nome_completo,
    categoria,
    departamento,
    regime,
    data_inicio_contrato,
    tipo_contrato,
    estado
)
FROM '/data/colaboradores.csv'
DELIMITER ','
CSV HEADER;

COPY ausencias (
    ausencia_id,
    colaborador_id,
    tipo_ausencia,
    data_inicio,
    data_fim,
    duracao_dias,
    aprovada
)
FROM '/data/ausencias.csv'
DELIMITER ','
CSV HEADER;

COPY projetos (
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
FROM '/data/projetos.csv'
DELIMITER ','
CSV HEADER;

COPY publicacoes_ria (
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
FROM '/data/publicacoes_ria.csv'
DELIMITER ','
CSV HEADER;