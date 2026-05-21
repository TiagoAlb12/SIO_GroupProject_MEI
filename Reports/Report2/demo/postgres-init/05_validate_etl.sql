\set ON_ERROR_STOP on

-- ============================================================
-- 05_validate_etl.sql
-- Validação simples do carregamento ETL.
-- Mostra contagens na staging e nas tabelas finais.
-- ============================================================

SELECT 'staging.cursos_raw' AS tabela, COUNT(*) AS total_registos FROM staging.cursos_raw
UNION ALL
SELECT 'staging.alunos_raw', COUNT(*) FROM staging.alunos_raw
UNION ALL
SELECT 'staging.unidades_curriculares_raw', COUNT(*) FROM staging.unidades_curriculares_raw
UNION ALL
SELECT 'staging.inscricoes_uc_raw', COUNT(*) FROM staging.inscricoes_uc_raw
UNION ALL
SELECT 'staging.orcamento_raw', COUNT(*) FROM staging.orcamento_raw
UNION ALL
SELECT 'staging.despesas_raw', COUNT(*) FROM staging.despesas_raw
UNION ALL
SELECT 'staging.colaboradores_raw', COUNT(*) FROM staging.colaboradores_raw
UNION ALL
SELECT 'staging.ausencias_raw', COUNT(*) FROM staging.ausencias_raw
UNION ALL
SELECT 'staging.projetos_raw', COUNT(*) FROM staging.projetos_raw
UNION ALL
SELECT 'staging.publicacoes_ria_raw', COUNT(*) FROM staging.publicacoes_ria_raw
UNION ALL
SELECT 'final.cursos', COUNT(*) FROM cursos
UNION ALL
SELECT 'final.alunos', COUNT(*) FROM alunos
UNION ALL
SELECT 'final.unidades_curriculares', COUNT(*) FROM unidades_curriculares
UNION ALL
SELECT 'final.inscricoes_uc', COUNT(*) FROM inscricoes_uc
UNION ALL
SELECT 'final.orcamento', COUNT(*) FROM orcamento
UNION ALL
SELECT 'final.despesas', COUNT(*) FROM despesas
UNION ALL
SELECT 'final.colaboradores', COUNT(*) FROM colaboradores
UNION ALL
SELECT 'final.ausencias', COUNT(*) FROM ausencias
UNION ALL
SELECT 'final.projetos', COUNT(*) FROM projetos
UNION ALL
SELECT 'final.publicacoes_ria', COUNT(*) FROM publicacoes_ria
ORDER BY tabela;