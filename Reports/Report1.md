# Report 1 – Business Intelligence System for UA

## 1. Introduction

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

Cada sistema tem sua própria área de atuação e funciona de forma independente. Isso dispersa as informações em várias plataformas e dificulta ter uma visão geral da organização.

## 3. Business Intelligence

### 3.1 Funcionalidades do sistema

De seguida, detalhamos as principais funcionalidades associadas a este tipo de sistemas:

* **Dashboards e Visualização de dados** – permitem a visualização de informação de forma gráfica e mais intuitiva;
* **KPIs (Key Performance Indicators)** – permitem definir e monitorizar indicadores importantes para a organização;
* **Reporting** – geração de relatórios, tanto ad-hoc, ou seja, relatórios que são criados mediante solicitações, como periódicos, com base nos dados disponíveis;
* **Análise interativa** – permite explorar os dados em mais detalhes para análises mais aprofundadas;
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

Após esta completa análise, desde o contexto da aplicação até à arquitetura do sistema de BI e respetivas funcionalidades, estamos aptos para avançar para a definição de um conjunto de requisitos que a mesma deverá cumprir.

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
| Integração com SQL                  | Possibilidade de executar queries SQL (nota: normalmente a Data Warehouse é relacional)             |
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


## 5. Estudo das Plataformas disponíveis no Mercado

Nesta secção, apresenta-se uma análise das principais plataformas de Business Intelligence (BI) open-source disponíveis no mercado, tendo em consideração as especificidades da Universidade de Aveiro (UA). A escolha recai sobre soluções open-source devido à sua flexibilidade, transparência e adequação a ambientes académicos com recursos técnicos especializados.

### 5.1 Identificação e Caracterização das Principais Ferramentas Open-Source

Com base na pesquisa realizada, identificaram-se cinco ferramentas open-source de BI com elevada relevância no mercado atual: **Apache Superset**, **Metabase**, **Redash**, **Grafana** e **Kibana** . A análise que se segue caracteriza cada uma delas.

| Plataforma | Tipo de Utilizador Alvo | Pontos Fortes | Pontos Fracos | Adequação ao Contexto UA |
| :--- | :--- | :--- | :--- | :--- |
| **Apache Superset** | Data Engineers, Analysts Técnicos | Visualizações ricas e interativas; suporta grandes volumes de dados; altamente personalizável . | Curva de aprendizagem íngreme; requer conhecimentos de programação para configuração avançada; deployment complexo . | Elevada. Ideal para equipas técnicas que necessitam de explorar dados académicos e de investigação complexos. |
| **Metabase** | Utilizadores de negócio, Equipas não técnicas | Interface intuitiva e fácil de usar; configuração rápida (5 minutos); permite consultas sem SQL; boa experiência de utilizador . | Funcionalidades limitadas para análises muito complexas; pode ter desempenho inferior com conjuntos de dados extremamente grandes . | Elevada. Perfeito para serviços administrativos (RH, Finanças) que precisam de consultar dados rapidamente sem depender de IT. |
| **Redash** | Analistas de Dados | Focado em consultas SQL; interface simples e eficaz; boa ligação a múltiplas fontes de dados . | Menos foco em dashboards interativos; capacidades de visualização menos ricas que o Superset ou Metabase. | Média. Pode ser útil para consultas ad-hoc específicas, mas poderá ser menos versátil para um sistema de BI institucional. |
| **Grafana** | Engenheiros de DevOps, Monitorização | Excelente para visualização de dados de séries temporais; dashboards muito performáticos; ideal para monitorização de infraestruturas . | Focado em dados de monitorização (métricas); não é uma ferramenta de BI de propósito geral para dados relacionais. | Média/Baixa. Mais adequado para monitorizar a saúde dos sistemas informáticos da UA do que para análise de dados académicos ou financeiros. |
| **Kibana** | Analistas de Logs | Faz parte do ecossistema Elastic; visualização e pesquisa de dados não estruturados (logs) . | Fortemente dependente da stack Elasticsearch; não é uma ferramenta de BI tradicional. | Baixa. A menos que a UA utilize intensivamente a stack ELK para logs, não será a escolha principal para BI. |

### 5.2 Análise Detalhada das Ferramentas Mais Promissoras

Para o contexto da UA, que necessita de integrar dados de sistemas heterogéneos (SIGACAD, SIGEF, RHumo) e servir diferentes perfis de utilizador (desde a administração até aos serviços técnicos), as ferramentas mais promissoras são **Apache Superset** e **Metabase**.

#### 5.2.1 Apache Superset

O Apache Superset é uma plataforma moderna, de código aberto e que se tornou um projeto de topo da Apache Foundation. É reconhecido pela sua capacidade de lidar com grandes volumes de dados e por oferecer um leque muito vasto de opções de visualização .

*   **Funcionalidades-Chave:**
    *   **Visualização de Dados:** Suporta uma grande variedade de gráficos, desde os mais simples (barras, linhas) até aos mais complexos (mapas, gráficos de sankey, séries temporais interativas).
    *   **Integração de Dados:** Conecta-se a uma vasta gama de bases de dados SQL, incluindo PostgreSQL, MySQL, Snowflake e BigQuery, que podem constituir a base do *Data Warehouse* da UA .
    *   **Análise Interativa:** Oferece uma interface rica para explorar dados, permitir *drill-down* e criar dashboards dinâmicos.
    *   **Customização:** Sendo open-source e com uma arquitetura flexível, permite que a equipa técnica da UA o personalize e integre com os sistemas existentes .

*   **Desvantagens:**
    *   **Complexidade:** A sua configuração e manutenção exigem conhecimentos sólidos de engenharia de dados e de gestão de servidores .
    *   **Curva de Aprendizagem:** Utilizadores não técnicos podem demorar mais tempo a adaptar-se à sua interface, comparativamente ao Metabase.

#### 5.2.2 Metabase

O Metabase posiciona-se como a ferramenta de BI mais fácil de usar, focada na democratização do acesso aos dados. É uma escolha popular para organizações que desejam que todos os seus membros, independentemente da sua literacia técnica, possam fazer perguntas aos seus dados .

*   **Funcionalidades-Chave:**
    *   **Facilidade de Utilização:** Apresenta uma interface limpa e intuitiva, onde os utilizadores podem criar perguntas e dashboards através de um construtor visual por "cliques", sem necessidade de escrever SQL .
    *   **Configuração Rápida:** Pode ser instalado e colocado em funcionamento em poucos minutos, o que é uma vantagem significativa para uma rápida adoção inicial .
    *   **Autenticação e Autorização:** Oferece controlos de acesso granulares, permitindo definir perfis de utilizador (ex: Direção, Serviços Académicos, Investigadores) e gerir o acesso aos dados de acordo com as políticas de segurança da UA .
    *   **Colaboração:** Facilita o *reporting* e a partilha de análises entre equipas.

*   **Desvantagens:**
    *   **Limitações em Big Data:** Embora funcione bem para a maioria das análises, pode sentir algum abrandamento com conjuntos de dados extremamente grandes ou consultas muito complexas .
    *   **Funcionalidades Avançadas:** Pode não ter a profundidade de análise e o leque de opções de visualização avançadas que o Superset oferece.

### 5.3 Comparação com Soluções Proprietárias (Domo)

Embora o foco seja em soluções open-source, é importante contextualizar a escolha. O **Domo** é uma plataforma proprietária, *all-in-one*, que combina integração de dados, armazenamento e visualização numa única solução na nuvem . Embora ofereça mais de 1000 conectores pré-construídos e uma experiência *drag-and-drop* amigável, apresenta desvantagens significativas para o contexto da UA :

*   **Custo Elevado:** O modelo de subscrição pode ser muito dispendioso para uma instituição de ensino superior, com custos que podem facilmente ultrapassar os 50.000€ anuais .
*   **Dependência de Fornecedor (*Vendor Lock-in*):** A UA ficaria dependente de uma plataforma fechada, perdendo a flexibilidade e controlo sobre os seus dados e infraestrutura .
*   **Falta de Transparência:** Sendo *closed-source*, não é possível aceder ao código-fonte para auditoria, personalização profunda ou para garantir que a plataforma cumpre todos os requisitos de segurança e transparência exigidos por uma universidade pública.

Desta forma, as soluções open-source alinham-se melhor com os princípios de autonomia, controlo e otimização de recursos que devem reger uma instituição académica.

### 5.4 Seleção da Plataforma Mais Promissora

Após a análise aprofundada, considera-se que a estratégia mais adequada para a Universidade de Aveiro não passa pela escolha de uma única ferramenta, mas sim pela adoção de um **modelo híbrido** que combine o **Apache Superset** e o **Metabase**. Esta abordagem permite tirar partido das vantagens de cada ferramenta, direcionando-as para os perfis de utilizador e casos de uso onde melhor se adequam.

| Perfil de Utilizador | Ferramenta Recomendada | Justificação |
| :--- | :--- | :--- |
| **Administração e Serviços** (Reitoria, Serviços Académicos, RH, Finanças, Diretores de Departamento) | **Metabase** | A facilidade de uso e a interface intuitiva permitem que estes utilizadores criem os seus próprios relatórios e dashboards para monitorizar KPIs de gestão (taxa de ocupação, execução orçamental, distribuição de estudantes por curso, etc.) sem dependerem constantemente da equipa de TI. A curva de aprendizagem reduzida é um fator crítico para a rápida adoção do sistema em toda a organização. |
| **Gabinete de Análise de Dados, Equipa Técnica de BI e Investigadores** | **Apache Superset** | A potência e flexibilidade do Superset são cruciais para explorar os dados mais complexos, como os do RIA (Repositório Institucional), para analisar padrões de sucesso académico, cruzar dados de projetos de investigação com recursos humanos e realizar análises profundas que suportem a definição da estratégia científica e pedagógica da Universidade. A capacidade de personalização e de lidar com grandes volumes de dados é essencial para este perfil. |

**Conclusão:** A implementação de um sistema de BI na UA, assente numa arquitetura híbrida com Metabase e Apache Superset, maximiza o valor do investimento. Ao aliar a experiência do utilizador à potência analítica, esta estratégia cria uma verdadeira cultura de dados, capacitando toda a comunidade académica — desde a gestão administrativa à investigação — a tomar decisões informadas e baseadas em evidências.

