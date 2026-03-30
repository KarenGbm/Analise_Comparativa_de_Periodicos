-- =========================================
-- 1. CRIAÇÃO DAS TABELAS
-- =========================================

CREATE TABLE arquivof1 (
    issn TEXT,
    title TEXT,
    periodico TEXT,
    qualis TEXT,
    fi_sjr numeric,
    h_index int,
    citacoes_2019_2021 int,
    citacoes_media int
);

CREATE TABLE arquivof2 (
    rank_position INTEGER,
    sourceid TEXT,
    title TEXT,
    type_name TEXT,
    issn TEXT,
    sjr TEXT,
    sjr_best_quartile TEXT,
    h_index INTEGER,
    total_docs2022 INTEGER,
    total_docs3years INTEGER,
    total_refs INTEGER,
    total_cites3years INTEGER,
    citable_docs3years INTEGER,
    cites_doc2years TEXT,
    ref_doc TEXT,
    country TEXT,
    region TEXT,
    publisher TEXT,
    coverage TEXT,
    categories TEXT,
    areas TEXT
);

-- =========================================
-- 2. TRATAMENTO DE DADOS
-- =========================================

-- Limpar ISSN (remover hífen e espaços)
UPDATE arquivof1
SET issn = TRIM(REPLACE(issn, '-', ''));

UPDATE arquivof2
SET issn = TRIM(REPLACE(issn, '-', ''));

--Criar coluna issn_clean
alter table arquivof2
add column ISSN_CLEAN text

alter table arquivof1
add column ISSN_CLEAN text


-- Limpar e converter sourceid
UPDATE arquivof2
SET sourceid = TRIM(REPLACE(sourceid, '.', ''));

ALTER TABLE arquivof2
ALTER COLUMN sourceid TYPE BIGINT USING sourceid::BIGINT;

-- =========================================
-- 3. PADRONIZAÇÃO DE TEXTO
-- =========================================

UPDATE arquivof1
SET periodico = INITCAP(periodico);

-- =========================================
-- 4. VIEW PARA SEPARAR ISSN
-- =========================================

CREATE OR REPLACE VIEW issn_por_publicacao AS
SELECT 
    title,
    TRIM(REPLACE(unnest(string_to_array(issn_clean, ',')), '-', '')) AS issn_clean
FROM arquivof2;

-- =========================================
-- 5. VIEW FINAL (ANÁLISE CRUZADA)
-- =========================================

CREATE OR REPLACE VIEW analise_periodicos_com_dados_completos AS
SELECT 
    v.issn_clean,
    v.title,
    a1.periodico,
    a1.qualis,
    a2.sjr,
    a2.sjr_best_quartile,
    a2.h_index,
    a2.total_cites_3years,
    a2.country,
    a2.rank_position
FROM issn_por_publicacao v
JOIN arquivof1 a1 
    ON v.issn_clean = a1.issn
LEFT JOIN arquivof2 a2 
    ON v.issn_clean = a2.issn;

-- =========================================
-- 6. VALIDAÇÃO DE DADOS
-- =========================================

-- ISSNs em comum entre as tabelas
SELECT issn FROM arquivof1
INTERSECT
SELECT issn FROM arquivof2;

-- Registros sem correspondência
SELECT *
FROM arquivof1 a1
LEFT JOIN arquivof2 a2
ON a1.issn = a2.issn
WHERE a2.issn IS NULL;

-- =========================================
-- 7. CONSULTA FINAL PARA BI
-- =========================================

SELECT *
FROM analise_periodicos_com_dados_completos 