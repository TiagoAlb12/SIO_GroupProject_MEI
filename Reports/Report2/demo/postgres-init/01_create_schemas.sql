CREATE TABLE IF NOT EXISTS cursos (
    curso_id TEXT PRIMARY KEY,
    designacao TEXT NOT NULL,
    departamento TEXT NOT NULL,
    ects_totais INTEGER,
    numero_vagas INTEGER,
    numero_inscritos_atual INTEGER,
    grau TEXT,
    ativo BOOLEAN
);

CREATE TABLE IF NOT EXISTS alunos (
    aluno_id TEXT PRIMARY KEY,
    nome_completo TEXT NOT NULL,
    genero TEXT,
    data_nascimento DATE,
    curso_id TEXT,
    departamento TEXT,
    ano_matricula INTEGER,
    estatuto TEXT,
    email_institucional TEXT,
    nacionalidade TEXT,
    regime TEXT,
    CONSTRAINT fk_alunos_curso
        FOREIGN KEY (curso_id) REFERENCES cursos(curso_id)
);

CREATE TABLE IF NOT EXISTS unidades_curriculares (
    uc_id TEXT PRIMARY KEY,
    designacao TEXT NOT NULL,
    ects INTEGER,
    departamento TEXT,
    ano_curricular INTEGER,
    semestre INTEGER,
    obrigatoria BOOLEAN
);

CREATE TABLE IF NOT EXISTS inscricoes_uc (
    inscricao_id TEXT PRIMARY KEY,
    aluno_id TEXT NOT NULL,
    uc_id TEXT NOT NULL,
    semestre INTEGER,
    ano_letivo TEXT,
    nota_final INTEGER,
    resultado TEXT,
    epoca TEXT,
    CONSTRAINT fk_inscricoes_aluno
        FOREIGN KEY (aluno_id) REFERENCES alunos(aluno_id),
    CONSTRAINT fk_inscricoes_uc
        FOREIGN KEY (uc_id) REFERENCES unidades_curriculares(uc_id)
);

CREATE TABLE IF NOT EXISTS orcamento (
    orcamento_id TEXT PRIMARY KEY,
    ano INTEGER NOT NULL,
    departamento TEXT NOT NULL,
    rubrica TEXT NOT NULL,
    dotacao_inicial NUMERIC(14,2),
    dotacao_atual NUMERIC(14,2),
    execucao_acumulada NUMERIC(14,2),
    percentagem_execucao NUMERIC(6,2)
);

CREATE TABLE IF NOT EXISTS despesas (
    despesa_id TEXT PRIMARY KEY,
    data_despesa DATE NOT NULL,
    departamento TEXT NOT NULL,
    rubrica TEXT NOT NULL,
    fornecedor TEXT,
    valor NUMERIC(14,2),
    estado TEXT,
    centro_custo TEXT
);

CREATE TABLE IF NOT EXISTS colaboradores (
    colaborador_id TEXT PRIMARY KEY,
    nome_completo TEXT NOT NULL,
    categoria TEXT,
    departamento TEXT,
    regime TEXT,
    data_inicio_contrato DATE,
    tipo_contrato TEXT,
    estado TEXT
);

CREATE TABLE IF NOT EXISTS ausencias (
    ausencia_id TEXT PRIMARY KEY,
    colaborador_id TEXT NOT NULL,
    tipo_ausencia TEXT,
    data_inicio DATE,
    data_fim DATE,
    duracao_dias INTEGER,
    aprovada BOOLEAN,
    CONSTRAINT fk_ausencias_colaborador
        FOREIGN KEY (colaborador_id) REFERENCES colaboradores(colaborador_id)
);

CREATE TABLE IF NOT EXISTS projetos (
    projeto_id TEXT PRIMARY KEY,
    titulo TEXT NOT NULL,
    departamento_lider TEXT,
    fonte_financiamento TEXT,
    orcamento_total NUMERIC(14,2),
    data_inicio DATE,
    data_fim DATE,
    estado TEXT,
    equipa_elementos INTEGER
);

CREATE TABLE IF NOT EXISTS publicacoes_ria (
    ria_id TEXT PRIMARY KEY,
    titulo TEXT NOT NULL,
    tipo_publicacao TEXT,
    departamento TEXT,
    data_publicacao DATE,
    ano_publicacao INTEGER,
    autores_numero INTEGER,
    downloads INTEGER,
    citacoes INTEGER,
    licenca_acesso TEXT
);

CREATE INDEX IF NOT EXISTS idx_alunos_curso_id
    ON alunos(curso_id);

CREATE INDEX IF NOT EXISTS idx_alunos_departamento
    ON alunos(departamento);

CREATE INDEX IF NOT EXISTS idx_uc_departamento
    ON unidades_curriculares(departamento);

CREATE INDEX IF NOT EXISTS idx_inscricoes_aluno_id
    ON inscricoes_uc(aluno_id);

CREATE INDEX IF NOT EXISTS idx_inscricoes_uc_id
    ON inscricoes_uc(uc_id);

CREATE INDEX IF NOT EXISTS idx_inscricoes_ano_letivo
    ON inscricoes_uc(ano_letivo);

CREATE INDEX IF NOT EXISTS idx_orcamento_ano_departamento
    ON orcamento(ano, departamento);

CREATE INDEX IF NOT EXISTS idx_despesas_data
    ON despesas(data_despesa);

CREATE INDEX IF NOT EXISTS idx_despesas_departamento
    ON despesas(departamento);

CREATE INDEX IF NOT EXISTS idx_colaboradores_departamento
    ON colaboradores(departamento);

CREATE INDEX IF NOT EXISTS idx_ausencias_colaborador_id
    ON ausencias(colaborador_id);

CREATE INDEX IF NOT EXISTS idx_ausencias_data_inicio
    ON ausencias(data_inicio);

CREATE INDEX IF NOT EXISTS idx_projetos_departamento_lider
    ON projetos(departamento_lider);

CREATE INDEX IF NOT EXISTS idx_publicacoes_departamento
    ON publicacoes_ria(departamento);

CREATE INDEX IF NOT EXISTS idx_publicacoes_ano
    ON publicacoes_ria(ano_publicacao);