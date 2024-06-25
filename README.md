# Qualivida - Gestão de Negócios para Clínicas

## Descrição
Este repositório contém a implementação de aplicações para gestão de negócios da clínica fictícia Qualivida. O objetivo principal é desenvolver programas que auxiliem no gerenciamento de médicos, pacientes e consultas, utilizando tecnologias SAP NetWeaver e ABAP.

## Funcionalidades Implementadas
- **ZTQV_CAD_PAC (Cadastro de Pacientes):** Transação para cadastro de novos pacientes, registrando dados como nome, área médica, data de nascimento, entre outros. Os dados são armazenados na tabela ZTBQV_PACIENTES.
- **ZTQV_UP_PAC (Atualização de Pacientes):** Permite a atualização dos dados de pacientes existentes, utilizando o ID do paciente como chave única. Após a atualização, registra automaticamente o usuário responsável e a data da modificação.
- **ZTQV_VIEW_PAC (Visualização de Pacientes):** Mostra os detalhes de um paciente específico a partir do ID fornecido pelo usuário. Os dados são exibidos em um ALV simples.
- **Atualização de Tabelas de Área Médica e Médicos:** Diálogos de atualização para as tabelas ZTBQV_AREA_MED e ZTBQV_MEDICOS, que armazenam informações sobre especialidades médicas e médicos da clínica.

## Relatório ZRQV_QUALIVIDA
- Este relatório exibe informações detalhadas sobre especialidades médicas ativas, médicos cadastrados, e dados relacionados a pacientes, consultas e pagamentos.
- Utiliza dois grids na tela: o primeiro para especialidades médicas com detalhes de médicos e status, e o segundo para dados de pacientes com semáforos coloridos indicando o status da consulta e pagamento.

## Especificação Funcional

### 1. Introdução
Este documento descreve os requisitos e funcionalidades específicas que a empresa fictícia Qualivida requer para gestão de seu negócio. O objetivo principal é o desenvolvimento de programas para o gerenciamento de negócio de forma geral, transações para gestão de médicos, pacientes e consultas.

### 2. Requisitos de Negócios

#### 2.1 Desenvolvimento da transação ZTQV_CAD_PAC para cadastro de pacientes
Os dados cadastrados através da transação serão salvos na tabela ZTBQV_PACIENTES, que terá os seguintes campos:

| Campo          | Elemento/dados   | Tipo | Tamanho | Descrição                     |
| -------------- | ---------------- | ---- | ------- | ----------------------------- |
| ID_PAC         | ZEDQV_ID_PAC     | INT1 | 3       | ID de identificação de pacientes |
| NOME           | ZEDQV_NOME_P     | CHAR | 25      | Nome do paciente              |
| AREA_MEDICA    | ZEDQV_AREA       | CHAR | 25      | Área de atuação               |
| DATA_NASCIMENTO| ZEDQV_DT_NASC    | DATS | 8       | Data de Nascimento            |
| CONSULTA_CONF  | ZEDQV_CON_CONF   | CHAR | 1       | Confirmação de Consulta       |
| PAGAMENTO_CONF | ZEDQV_PAG_CONF   | CHAR | 1       | Confirmação de pagamento      |
| VALOR          | ZEDQV_VALOR      | INT8 | 19      | Valor consulta                |
| CAD_EM         | ZEDQV_CAD_EM     | DATS | 8       | Data do cadastro              |
| CAD_POR        | ZEDQV_CAD_POR    | CHAR | 20      | Cadastrado por                |
| ALTERADO_EM    | ZEDQV_UP_EM      | DATS | 8       | Data de atualização de cadastro |
| ALTERADO_POR   | ZEDQV_UP_POR     | CHAR | 20      | Atualizado por                |

##### Procedimentos para cadastro de pacientes:
1. O ID do paciente deve ser gerado automaticamente.
2. No ato do cadastro será gravado no campo CAD_POR, o usuário que efetuou o cadastro do paciente, e no campo CAD_EM a data e a hora que o cadastro foi criado.
3. O campo PAGAMENTO_CONF será marcado automaticamente, quando o campo VALOR for preenchido.
4. Os campos ID_PAC, CAD_EM, CAD_POR, ALTERADO_EM, ALTERADO_POR, não serão visíveis na tela de cadastro.
![Captura de tela 2024-06-25 190243](https://github.com/Erivanildo-maciel/qualivida/assets/128848036/74d5ae1d-71e2-4ff1-8093-8375beb5eb5d)

#### 2.2 Desenvolvimento da transação ZTQV_UP_PAC para atualizar os dados de pacientes
1. Na tela de atualização de cadastro, terá apenas um campo o ID_PAC "ID do Paciente".
2. Fazer uma consulta para retornar os dados do paciente a partir do ID informado.
3. Alimentar a estrutura da tela de cadastro, com os dados obtidos na consulta, para permitir a adição dos dados.
4. Obs.: o ID do Paciente é inalterável.
5. Se os dados forem atualizados, exibir mensagens de sucesso “Os dados foram atualizados com sucesso!”.
6. Caso não exista dados para o ID informado, exibir a mensagem “Não existe paciente com o ID informado!”.
7. Os campos ALTERADO_EM e ALTERADO_POR serão preenchidos com o usuário a data e a hora da atualização.
![Captura de tela 2024-06-25 190412](https://github.com/Erivanildo-maciel/qualivida/assets/128848036/f06609a7-b3ce-41c3-a412-8ac11c97e2a1)

#### 2.3 Desenvolvimento da transação ZTQV_VIEW_PAC, para visualização dos dados de pacientes
1. A transação deverá ter somente o campo ID do paciente.
2. A partir do id informado pelo usuário, buscar os dados na tabela ZTBQV_PACIENTES.
3. Caso exista dados para o ID informado, exibir os dados em um ALV simples.
4. Caso não exista dados será exibido a seguinte mensagem: “Não existe paciente para o ID informado!”.
![Captura de tela 2024-06-25 190515](https://github.com/Erivanildo-maciel/qualivida/assets/128848036/21d4505f-f1e6-4ede-b345-18215c9c0535)

#### 2.4 Desenvolvimento diálogo de atualização de tabela para a Tabela ZTBQV_AREA_MED
Onde serão gravados os dados referentes às especialidades médicas que a clínica oferece atendimento. A tabela terá os seguintes campos:

| Campo          | Elemento/dados   | Tipo | Tamanho | Descrição                     |
| -------------- | ---------------- | ---- | ------- | ----------------------------- |
| ESPECIALIDADE  | ZEDQV_AREA       | CHAR | 25      | Área Médica                   |
| DATA_INICIO    | ZEDQV_DT_I       | DATS | 8       | Início Consultas              |
| DATA_FIM       | ZEDQV_DT_F       | DATS | 8       | Fim Consultas                 |
| ATIVO          | ZEDQV_ATIVO      | CHAR | 1       | Status (I) / (A)              |

Obs.: O elemento de dados do campo ATIVO terá domínio ZDQV_ATIVO com valores: (I) Para especialidade INATIVA e (A), para ATIVA.
![Captura de tela 2024-06-25 190555](https://github.com/Erivanildo-maciel/qualivida/assets/128848036/134e86cf-511f-4ded-9a66-e71908dbe108)

#### 2.5 Desenvolvimento diálogo de atualização de tabela para a Tabela ZTBQV_MEDICOS
Onde serão gravados os dados referente aos médicos que atendem pela clínica. A tabela terá os seguintes campos:

| Campo          | Elemento/dados   | Tipo | Tamanho | Descrição                     |
| -------------- | ---------------- | ---- | ------- | ----------------------------- |
| NOME           | ZEDQV_NOME       | CHAR | 25      | Nome do médico                |
| ESPECIALIDADE  | ZEDQV_AREA       | CHAR | 25      | Área de atuação               |
![Captura de tela 2024-06-25 190623](https://github.com/Erivanildo-maciel/qualivida/assets/128848036/82fe260e-0709-49d3-8984-650b33bd2000)

#### 2.6 Desenvolvimento do relatório ZRQV_QUALIVIDA
Exibindo 2 grids na tela, no primeiro grid será exibido os dados para acompanhamento das especialidades com a data de início e data fim e se a está ativa ou não no segundo grid os dados referentes a pacientes, consultas, pagamento e valores.
1. O primeiro grid terá as seguintes funcionalidades: a coluna de especialidades terá o evento hotspot, quando o usuário clicar em alguma especialidade será exibido um popup com os dados dos médicos que estão cadastrados para a especialidade, verificar se a especialidade está ativa e aplicar o layout de negrito para as datas de início e data fim.
2. No segundo grid onde será exibido os dados de pacientes, referentes à confirmação de consultas, confirmação de pagamentos, valores.
   - Liberar a coluna de valor, para ser editada através do próprio grid.
   - Organizar a tabela de forma crescente e por valor, e aplicar o auto soma por especialidade, e o total da coluna.
   - Aplicar semáforo no grid e colorir a linha de acordo com o semáforo seguindo a seguinte lógica:
     - Para paciente que está com consulta confirmada, pagamento confirmado, e valor preenchido, o semáforo é verde e linha verde.
     - Para paciente que está com consulta marcada, sem confirmação de pagamento e sem valor preenchido, o semáforo é amarelo.
     - Para paciente que não está com a consulta marcada nem pagamento confirmado e nem valor preenchido, o semáforo é vermelho.
   - Como o grid está editável, temos que deixar o semáforo “Dinâmico” para quando o usuário alterar algum dado no grid, ao salvar os dados alterados o semáforo alterar a cor de acordo com a lógica.
![Captura de tela 2024-06-25 190800](https://github.com/Erivanildo-maciel/qualivida/assets/128848036/dbcc0bb0-393d-4b13-a881-9a0ac3364b2c)

## Tecnologias Utilizadas
- **ABAP:** Desenvolvimento de programas, transações e relatórios utilizando ABAP, ABAP OO, MODULE-POOL.

