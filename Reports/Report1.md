# Relatório 1 – Sistema de Business Intelligence para a Universidade de Aveiro

## 1. Introdução

Hoje em dia, as organizações dependem muito de dados e informações para tomar decisões. No entanto, com tantos sistemas de informação diferentes e independentes, é difícil ter uma visão clara e completa.

Nesse sentido, abordamos o conceito de Business Intelligence (BI) na medida em que é representado por um conjunto de processos, tecnologias e ferramentas que permitem recolher, integrar e apresentar dados de forma estruturada.

---

## 2. Contexto da Aplicação (UA)

A Universidade de Aveiro (UA) é uma organização complexa, composta por múltiplos departamentos, utilizadores e sistemas de informação que suportam diferentes áreas funcionais.

Atualmente, a UA utiliza vários sistemas independentes, nomeadamente:

* SIGACAD – Sistema de Gestão Académica
* SIGEF – Sistema de Gestão Financeira
* RHumo – Sistema de Gestão de Recursos Humanos
* PACO – Portal Académico
* Sistema de Gestão de Projetos
* RIA – Repositório Institucional

Cada sistema tem a sua própria área de atuação e funciona de forma independente. Esta realidade conduz à dispersão as informações por várias plataformas e dificulta ter uma visão geral da organização.

Neste contexto, torna-se evidente a necessidade de uma solução de Business Intelligence capaz de integrar estas fontes de dados e disponibilizar informação consolidada.

## 3. Business Intelligence

### 3.1 Funcionalidades do sistema

De seguida, detalhamos as principais funcionalidades associadas a este tipo de sistemas:

* **Dashboards e Visualização de dados** – permitem a visualização de informação de forma gráfica e mais intuitiva;
* **KPIs (Key Performance Indicators)** – permitem definir e monitorizar indicadores importantes para a organização;
* **Reporting** – geração de relatórios, tanto ad-hoc, ou seja, relatórios que são criados mediante solicitações, como periódicos, com base nos dados disponíveis;
* **Análise interativa** – permite explorar os dados com maior detalhes para análises mais aprofundadas;
* **Integração de dados** – processos de extração e transformação de dados provenientes de diferentes fontes.

Estas funcionalidades permitem transformar grandes volumes de dados em informação compreensível, facilitando a identificação de padrões, tendências e oportunidades.

### 3.2 Arquitetura do sistema

Um sistema de BI normalmente é composto por várias camadas. 

Numa primeira fase, os dados são extraídos de diversas fontes, como acontece, por exemplo, nos sistemas existentes na UA, como SIGACAD, SIGEF ou RHumo.
Estes dados são posteriormente processados através de mecanismos de ETL (Extract, Transform, Load), que permitem o seu tratamento, transformação e integração.
Após este processo, os dados são armazenados num **Data Warehouse**, onde ficam organizados de forma estruturada e consistente.
As ferramentas de BI acedem ao mesmo para apresentarem as informações. Este processo é feito através das funcionalidades que abordámos no tópico anterior.

Desta forma, este tipo de arquitetura permite transformar dados provenientes de múltiplas fontes heterogéneas em informação integrada, consistente e útil.


## 4. Especificações

Após toda esta análise realizada, desde o contexto da aplicação até à arquitetura do sistema de BI e respetivas funcionalidades, estamos aptos para avançar para a definição de um conjunto de requisitos que a ferramenta deverá cumprir.

### 4.1 Requisitos Funcionais

| Requisito              | Descrição                                                     |
| ---------------------- | ------------------------------------------------------------- |
| Dashboards interativos | Possibilidade de criar dashboards dinâmicos e intuitivos      |
| KPIs                   | Definição e monitorização de indicadores de desempenho        |
| Reporting              | Criação de relatórios ad-hoc e periódicos                     |
| Análise interativa     | Capacidade de explorar dados em detalhe              |
| Visualização de dados  | Suporte a gráficos e tabelas para interpretação da informação |
| Integração de dados    | Capacidade de recolher e combinar dados de diferentes fontes  |

---

### 4.2 Requisitos Não Funcionais

#### 4.2.1 Requisitos Técnicos

| Requisito                           | Descrição                                         |
| ----------------------------------- | ------------------------------------------------- |
| Suporte a múltiplas fontes de dados | Capacidade de ligação a diferentes bases de dados |
| Suporte a mecanismos de consulta de dados (ex: SQL)                  | Possibilidade de executar queries SQL              |
| Escalabilidade                      | Capacidade de lidar com grandes volumes de dados  |
| Performance                         | Tempo de resposta adequado na análise de dados    |

---

#### 4.2.2 Requisitos de Integração

| Requisito                            | Descrição                                                   |
| ------------------------------------ | ----------------------------------------------------------- |
| Integração com sistemas heterogéneos | Capacidade de integração                  |
| Compatibilidade de formatos          | Suporte a diferentes formatos de dados                      |

---

#### 4.2.3 Requisitos de Segurança

| Requisito         | Descrição                           |
| ----------------- | ----------------------------------- |
| Autenticação      | Controlo de acesso de utilizadores  |
| Autorização       | Gestão de permissões por perfil     |
| Proteção de dados | Garantia de segurança da informação |

---

#### 4.2.4 Requisitos de Usabilidade

| Requisito                  | Descrição                                |
| -------------------------- | ---------------------------------------- |
| Interface intuitiva        | Facilidade de utilização                 |
| Facilidade de aprendizagem | Curva de aprendizagem reduzida           |

---

Desta forma, os requisitos apresentados servirão como base para a análise das ferramentas disponíveis no mercado e para a seleção da solução de BI mais adequada ao nosso contexto.


# 5. Estudo das Plataformas disponíveis no Mercado

Com base na análise de ferramentas de BI open source e gratuitas disponíveis atualmente no mercado, foram identificadas as principais plataformas com potencial de aplicação no contexto da Universidade de Aveiro (UA). A seguinte tabela apresenta um resumo comparativo das ferramentas estudadas.

---

## 5.1 Plataformas Identificadas

| Plataforma | Tipo | Principais Características | Integração SQL | Visualização | Escalabilidade | Custo | Pontos Fortes | Pontos Fracos |
|---|---|---|:---:|:---:|:---:|---|---|---|
| **Metabase** | Open Source | Interface simples, dashboards interativos, suporte a 20+ bases de dados, sem necessidade de SQL | ✔️ | ✔️ | Médio | Gratuito | Interface muito intuitiva; ideal para utilizadores não técnicos; setup rápido | Sem conformidade SOC2 na versão open source; funcionalidades avançadas limitadas |
| **Apache Superset** | Open Source | 40+ tipos de visualização, construtor no-code, caching de dados, suporte a qualquer base SQL | ✔️ | ✔️ | Alto | Gratuito | Altamente escalável; grande variedade de visualizações; comunidade ativa | Instalação e configuração complexas; curva de aprendizagem elevada para administradores |
| **KNIME** | Open Source | ETL integrado, machine learning, suporte a Python/R, 300+ conectores | ✔️ | ✔️ | Alto | Gratuito | ETL nativo poderoso; suporte a ML e análise avançada; 300+ conectores | Interface mais orientada a data scientists; menos adequado para utilizadores de negócio |
| **Lightdash** | Open Source | Self-service BI, integração com dbt, análise em linguagem natural, alertas automáticos | ✔️ | ✔️ | Médio | Gratuito | Integração nativa com dbt; suporte a linguagem natural; alertas automáticos | Requer conhecimento de dbt; ecossistema ainda em maturação |
| **Redash** | Open Source | SQL client, suporte a NoSQL e Big Data, dashboards partilháveis, gestão de utilizadores | ✔️ | ✔️ | Médio | Gratuito | Focado em SQL; suporte a NoSQL e Big Data; dashboards partilháveis | Desenvolvimento da versão open source menos ativo; UI menos moderna |
| **Jaspersoft Community Ed.** | Open Source | Motor de relatórios JasperReports, exportação em PDF/Excel/HTML, suporte a múltiplas fontes | ✔️ | ✔️ | Médio | Gratuito | Motor de relatórios robusto; múltiplos formatos de exportação | Sem multi-tenancy nem análise in-memory na versão community; interface datada |
| **BIRT** | Open Source | Relatórios embebidos, múltiplas fontes de dados, scripting em Java/JavaScript | ✔️ | ✔️ | Médio | Gratuito | Boa integração com aplicações Java; reutilização de relatórios em biblioteca | Tecnologia mais antiga; suporte e comunidade menos ativos |
| **Looker Studio** | Gratuito | 800+ conectores, templates de relatórios, integração com Google Workspace | ✔️ | ✔️ | Alto | Gratuito | 800+ conectores; fácil partilha; integração nativa com Google Workspace | Dependência do ecossistema Google; funcionalidades avançadas requerem Looker pago |
| **Tableau Public** | Freemium | Visualizações interativas, comunidade ativa, exportação limitada | Limitado | ✔️ | Baixo | Gratuito (limitado) | Visualizações de alta qualidade; grande comunidade; recursos de aprendizagem gratuitos | Dados obrigatoriamente públicos; sem refresh automático; sem SQL nativo |
| **Power BI (Free)** | Freemium | Integração com Microsoft 365, 1 GB de capacidade, atualização diária | ✔️ | ✔️ | Médio | Gratuito (limitado) | Integração com Microsoft 365; interface familiar; segurança robusta | Limite de 1 GB; sem partilha na versão gratuita; requer upgrade para colaboração |

> Fonte: [Domo – 10 Best Open Source & Free BI Tools for 2025](https://www.domo.com/learn/article/open-source-bi-tools)

---

## 5.2 Critérios de Seleção

Para identificar a plataforma mais adequada ao contexto da UA, foram definidos critérios de seleção alinhados com os requisitos funcionais e não funcionais estabelecidos no ponto 4.

| Critério | Peso | Justificação |
|---|---|---|
| Integração com múltiplas fontes | Alto | A UA possui vários sistemas heterogéneos (SIGACAD, SIGEF, RHumo, etc.) |
| Suporte a SQL | Alto | O Data Warehouse terá de ser relacional |
| Capacidade de visualização | Alto | Dashboards e KPIs são requisitos centrais do sistema |
| Facilidade de utilização | Médio | Deve ser acessível a qualquer tipo de utilizadores |
| Escalabilidade | Médio | Volume crescente de dados académicos, financeiros e de RH |
| Suporte a relatórios ad-hoc | Médio | Necessidade da elaboração de relatórios |
| Custo | Alto | Contexto universitário público, preferência por soluções open source |
| Comunidade e suporte | Médio | Procura de facilitar a manutenção e evolução do sistema |
| Segurança e controlo de acessos | Alto | Dados sensíveis de alunos, funcionários e finanças |

---

# 6. Plataforma Selecionada: Apache Superset

Após análise comparativa das plataformas identificadas e aplicação dos critérios definidos, a plataforma selecionada para o contexto da UA é o **Apache Superset**.

### Justificação

O Apache Superset destaca-se como a solução mais adequada pelos seguintes motivos:

- **Integração com SQL**: Conecta-se nativamente a qualquer base de dados relacional via SQLAlchemy, tornando-o totalmente compatível com o Data Warehouse da UA.
- **Variedade de visualizações**: Disponibiliza mais de 40 tipos de visualizações, incluindo gráficos, mapas e tabelas dinâmicas, respondendo às necessidades de dashboards e KPIs.
- **Interface no-code e SQL IDE**: Suporta tanto utilizadores técnicos (com SQL) como não técnicos (através do construtor visual), relevante num ambiente universitário com perfis variados.
- **Escalabilidade**: Construído para lidar com grandes volumes de dados, adequado para o crescimento futuro da UA.
- **Open Source e gratuito**: Desenvolvido sob a Apache Software Foundation, com comunidade ativa e sem custos de licenciamento.
- **Segurança**: Suporta autenticação e controlo de acessos por perfil, compatível com os requisitos de segurança definidos.
- **Análise interativa**: Funcionalidades de cross-filter, drill-by e caching permitem explorações aprofundadas com boa performance.

Em suma, o Apache Superset responde de forma abrangente aos requisitos funcionais e não funcionais estabelecidos para o sistema de BI da Universidade de Aveiro, constituindo a escolha mais fundamentada e equilibrada entre as opções analisadas.