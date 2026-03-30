# Analise Comparativa de Periodicos dos cursos de Ciências Humanas

1. Contexto e Preparação dos Dados
Inicialmente, foram importados dois arquivos CSV para o PostgreSQL. Para facilitar a manipulação dos dados, utilizei o Dbeaver.

Após, foram realizados tratamentos para garantir a integridade e consistência dos dados,
incluindo correção de nomes de colunas, padronização de textos e de nomes de colunas, tratamento de duplicatas e
nulos, além de ajustes de tipos de dados.
Também foi realizada a padronização do ISSN com a criação da coluna ISSN_CLEAN, incluindo separação de múltiplos valores e
remoção de caracteres inválidos.

3. Integração das Bases
Foi criada uma view unificada contendo informações como ISSN, título, QUALIS, SJR, quartil,
H-index, citações e país. Após a padronização do ISSN, a correspondência entre as bases
aumentou significativamente, resultando em aproximadamente 1500 registros válidos para
análise.

4. Análises Realizadas
   
3.1 Qualidade das Publicações (QUALIS)
A distribuição das classificações QUALIS mostrou predominância de periódicos em níveis
intermediários, com maior concentração em periódicos de excelência (A1).

3.2 Impacto vs Volume
Observou-se uma tendência positiva entre o número de citações e o SJR, indicando que
periódicos mais citados tendem a ter maior impacto. No entanto, essa relação não é perfeita,
havendo casos de periódicos com muitas citações e baixo impacto. O QUALIS também não se
mostrou totalmente alinhado com métricas internacionais.

3.3 Benchmarking Internacional
Os periódicos internacionais apresentam maior média de SJR e H-index em comparação aos
brasileiros. Apenas cerca de 10% dos periódicos estão classificados como Q1, indicando
baixa representatividade de alto impacto na base analisada.

6. KPIs
Foram criados indicadores-chave, incluindo total de periódicos, média de citações(3 anos) e
percentual de periódicos Q1 (~10%).

8. Implicações
Durante o processo de integração das bases, foi identificado que, apesar do volume inicial bastante elevado de registros, apenas aproximadamente 1500 registros puderam ser efetivamente utilizados na análise cruzada. Isso ocorreu devido a diferença de padronização do ISSN entre as duas bases, existência de multiplo issn para o mesmo periódico e dados ausentes. Sendo assim, a análise foi realizada sobre a interseção das bases. Os resultados refletem apenas os dados com registros em comum. 

11. Conclusões
A análise evidencia que métricas quantitativas (citações) e classificações institucionais
(QUALIS) não são perfeitamente alinhadas. A base apresenta maior concentração em
periódicos de impacto intermediário e menor presença em periódicos de alto impacto.
