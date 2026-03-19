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
