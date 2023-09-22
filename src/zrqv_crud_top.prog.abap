*&---------------------------------------------------------------------*
*& Include          ZRQV_CRUD_TOP
*&---------------------------------------------------------------------*
"Estruturas para serem utilizadas nas telas de cadastro, modificação e exibição de pacientes
DATA: ls_pacientes TYPE ztbqv_pacientes.

"Estrutura para serem utilizadas na tela de atualização de cadastro de pacientes
DATA: ls_up_pacientes TYPE ztbqv_pacientes.

"Tabela interna e estrutura da tabela de pacientes.
DATA: lt_pacientes TYPE TABLE OF ztbqv_pacientes,
      wa_pacientes TYPE ztbqv_pacientes.
