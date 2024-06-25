# Qualivida - Gestão de Negócios para Clínicas

## Descrição
Este repositório contém a implementação de aplicações para gestão de negócios da clínica fictícia Qualivida. O objetivo principal é desenvolver programas que auxiliem no gerenciamento de médicos, pacientes e consultas, utilizando tecnologias SAP ABAP.

## Funcionalidades Implementadas
- **ZTQV_CAD_PAC (Cadastro de Pacientes):** Transação para cadastro de novos pacientes, registrando dados como nome, área médica, data de nascimento, entre outros. Os dados são armazenados na tabela ZTBQV_PACIENTES.
![image](https://github.com/Erivanildo-maciel/qualivida/assets/128848036/05f8fa2c-0077-423c-a7dd-7aed653fdc84)

- **ZTQV_UP_PAC (Atualização de Pacientes):** Permite a atualização dos dados de pacientes existentes, utilizando o ID do paciente como chave única. Após a atualização, registra automaticamente o usuário responsável e a data da modificação.
![image](https://github.com/Erivanildo-maciel/qualivida/assets/128848036/21b6b910-94f7-4ff1-af04-b62d9f2ae72c)

- **ZTQV_VIEW_PAC (Visualização de Pacientes):** Mostra os detalhes de um paciente específico a partir do ID fornecido pelo usuário. Os dados são exibidos em um ALV simples.
![image](https://github.com/Erivanildo-maciel/qualivida/assets/128848036/e5b80c7e-cb56-46a3-a4a8-a9023b2e0afc)

- **Atualização de Tabelas de Área Médica e Médicos:** Diálogos de atualização para as tabelas ZTBQV_AREA_MED e ZTBQV_MEDICOS, que armazenam informações sobre especialidades médicas e médicos da clínica.
![image](https://github.com/Erivanildo-maciel/qualivida/assets/128848036/2c4b4646-a29f-4eb7-a99e-8acd14213122)
![image](https://github.com/Erivanildo-maciel/qualivida/assets/128848036/5545f98c-0df7-4980-8240-89f7d9b65946)

## Relatório ZRQV_QUALIVIDA
- Este relatório exibe informações detalhadas sobre especialidades médicas ativas, médicos cadastrados, e dados relacionados a pacientes, consultas e pagamentos.
- Utiliza dois grids na tela: o primeiro para especialidades médicas com detalhes de médicos e status, e o segundo para dados de pacientes com semáforos coloridos indicando o status da consulta e pagamento.
![image](https://github.com/Erivanildo-maciel/qualivida/assets/128848036/848dce52-2502-4ebd-9763-19ac783809d1)

## Tecnologias Utilizadas
- **ABAP:** Desenvolvimento de programas, transações e relatórios utilizando ABAP e ABAP OO.

## Objetivos
Desenvolver funcionalidades específicas que a empresa QUALIVIDA requer para gestão de seu negócio. O objetivo principal é o desenvolvimento abrangente de transações para gestão de médicos, pacientes e consultas.

## Como Contribuir
Contribuições são bem-vindas! Sinta-se à vontade para enviar pull requests com melhorias, correções de bugs ou novas funcionalidades.

## Contato
Para mais informações ou sugestões, entre em contato diretamente aqui no GitHub ou via e-mail [macielerivanildo@gmail.com].
