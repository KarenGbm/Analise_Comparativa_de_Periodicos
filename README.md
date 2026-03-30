

# 📊 Análise de Periódicos Científicos

## 1. Contexto e Preparação dos Dados

Inicialmente, foram importados dois arquivos CSV para o PostgreSQL. Para facilitar a manipulação dos dados, foi utilizada a ferramenta **DBeaver**.

Após a importação, foram realizados diversos tratamentos com o objetivo de garantir a **integridade e consistência dos dados**, incluindo:

* Correção e padronização dos nomes de colunas
* Padronização de textos
* Tratamento de valores nulos
* Remoção de duplicidades
* Ajustes de tipos de dados

Além disso, foi realizada a padronização do **ISSN**, com a criação da coluna `ISSN_CLEAN`, contemplando:

* Separação de múltiplos ISSNs em um único campo
* Remoção de caracteres inválidos
* Normalização do formato

---

## 2. Integração das Bases

Foi criada uma **view unificada** contendo as seguintes informações:

* ISSN
* Título
* QUALIS
* SJR
* Quartil
* H-index
* Número de citações
* País

Após a padronização do ISSN, houve um aumento significativo na correspondência entre as bases, resultando em aproximadamente **1500 registros válidos** para análise.

---

## 3. Análises Realizadas

### 3.1 Qualidade das Publicações (QUALIS)

A distribuição das classificações QUALIS evidenciou:

* Predominância de periódicos em níveis intermediários
* Maior concentração em periódicos de excelência (**A1**)

---

### 3.2 Impacto vs Volume

Foi observada uma **tendência positiva** entre:

* Número de citações
* Índice SJR

Ou seja, periódicos mais citados tendem a apresentar maior impacto. No entanto:

* A relação não é perfeitamente linear
* Existem periódicos com muitas citações e baixo impacto
* O QUALIS não está totalmente alinhado com métricas internacionais

---

### 3.3 Benchmarking Internacional

A análise comparativa mostrou que:

* Periódicos internacionais possuem maior média de **SJR** e **H-index**
* Apenas cerca de **10% dos periódicos são classificados como Q1**

Isso indica uma **baixa representatividade de periódicos de alto impacto** na base analisada.

---

## 4. KPIs (Indicadores-Chave)

Foram definidos os seguintes indicadores:

* Total de periódicos
* Média de citações (últimos 3 anos)
* Percentual de periódicos Q1 (~10%)

---

## 5. Implicações da Análise

Durante o processo de integração das bases, foi identificado que:

* Apesar do grande volume inicial de dados, apenas ~1500 registros puderam ser utilizados
* Principais causas:

  * Diferenças na padronização do ISSN
  * Existência de múltiplos ISSNs para o mesmo periódico
  * Dados ausentes

Portanto:

👉 A análise foi realizada **apenas sobre a interseção das bases**
👉 Os resultados refletem **somente os registros em comum entre as fontes**

---

## 6. Construção do Dashboard (Power BI)

O dashboard foi desenvolvido no **Power BI**, com conexão direta ao banco PostgreSQL previamente estruturado.

### Fonte de Dados

* Utilização de uma **view unificada** construída no banco
* Dados já tratados e integrados previamente

---

### Medidas DAX

#### 📌 Percentual de Periódicos Q1

```DAX
%PeriodicosQ1 = 
DIVIDE(
    CALCULATE(
        COUNT('public analise_periodicos_com_dados_completos'[issn_clean]),
        'public analise_periodicos_com_dados_completos'[sjr_best_quartile] = "Q1"
    ),
    CALCULATE(
        COUNT('public analise_periodicos_com_dados_completos'[issn_clean]),
        ALL('public analise_periodicos_com_dados_completos')
    )
)
```

---

#### 🌍 Classificação por Região

```DAX
Regiao = IF([country] = "Brazil", "Brasil", "Internacional")
```

---

### Visualizações Utilizadas

* Gráficos de barras
* Gráficos de dispersão
* Barras empilhadas
* Tabelas
* Cartões (KPIs)

---

## 7. Conclusões

A análise evidencia que:

* Métricas quantitativas (**citações**) e classificações institucionais (**QUALIS**) **não estão totalmente alinhadas**
* Existe uma maior concentração de periódicos em **níveis intermediários de impacto**
* Há uma **baixa presença de periódicos de alto impacto (Q1)** na base analisada

---
