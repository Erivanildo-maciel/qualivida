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

## Tecnologias Utilizadas
- **ABAP:** Desenvolvimento de programas, transações e relatórios utilizando ABAP.
- **SAP NetWeaver:** Integração e administração de sistemas SAP NetWeaver para suportar as funcionalidades desenvolvidas.

## Objetivos
Este projeto foi desenvolvido como parte de um curso de SAP NetWeaver, adaptando conceitos de gestão para o cenário de uma clínica médica. O objetivo é demonstrar habilidades em desenvolvimento ABAP e integração com sistemas SAP.

## Como Contribuir
Contribuições são bem-vindas! Sinta-se à vontade para enviar pull requests com melhorias, correções de bugs ou novas funcionalidades. Para grandes alterações, por favor, abra uma issue para discutir antes.

## Contato
Para mais informações ou sugestões, entre em contato diretamente aqui no GitHub ou via e-mail [seu-email@exemplo.com].
