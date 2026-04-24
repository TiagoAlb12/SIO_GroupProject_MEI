# SIO_GroupProject
Business Intelligence Report2 

# Plataforma de Business Intelligence para a Universidade de Aveiro

## Visão Geral

O objetivo deste projeto consiste na conceção e implementação de uma solução de **Business Intelligence (BI)** capaz de integrar e analisar dados provenientes de múltiplos sistemas institucionais.

A plataforma foi construída com base no **Apache Superset**, utilizando dados simulados que representam sistemas relevantes da universidade, tais como:
- Gestão Académica (SIGACAD);
- Sistemas Financeiros;
- Recursos Humanos.

---

## Arquitetura

A solução segue uma arquitetura típica de BI:

- **Fontes de Dados** → Sistemas institucionais simulados;
- **Data Warehouse** → PostgreSQL;
- **Camada de Visualização** → Apache Superset;
- **Infraestrutura** → Docker Compose.

---

## Funcionalidades

- Dashboards interativos com indicadores-chave (KPIs);
- Análise multidimensional (académica, financeira e RH);
- Integração de dados de múltiplos esquemas;
- Interface personalizada alinhada com a identidade visual da Universidade de Aveiro.

---

## Como Executar

Para executar o projeto num novo ambiente:

```bash
git clone <repository-url>
cd Reports/Report2/demo
docker compose up -d --build
cd backup
chmod +x setup.sh
setup.sh
```

Após esta etapa, já possuímos a nossa dashboard de BI populada.

Resta-nos apenas colocar o nosso tema personalizado nos themes do Apache Superset.
Para tal, no canto superior direito, em *Settings*, selecionamos a opção *Theme*. Criamos um novo tema, que podemos nomear de *UA_THEME* e colocamos o JSON presente em ```/demo/theme```.
Guardamos e aplicamos as alterações, terminado assim este processo.

## Equipa do Projeto

<table>
  <tr>

<td align="center" width="50px;"></td>
    <td align="center"><a href="https://github.com/TiagoAlb12"><img src="https://avatars0.githubusercontent.com/TiagoAlb12?v=3" width="150px;" alt="Tiago"/><br /><sub><b>Tiago Albuquerque</b><br><i>112901</i><br>
    </td>
    <td align="center"><a href="https://github.com/ttabelhaxd"><img src="https://avatars0.githubusercontent.com/ttabelhaxd?v=3" width="150px;" alt="Abel"/><br /><sub><b>Abel Teixeira</b><br><i>113655</i></td>  
    <td align="center"><a href="https://github.com/Jose-Pedro-Ferreira-Marques"><img src="https://avatars0.githubusercontent.com/Jose-Pedro-Ferreira-Marques?v=3" width="150px;" alt="Pequeno Zé"/><br /><sub><b>José Marques</b><br><i>114321</i></td>

<td align="center" width="50px;"></td>
</tr>
</table>