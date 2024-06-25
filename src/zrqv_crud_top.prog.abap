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

"Classe para exibir os dados como alv.
DATA: ir_alv TYPE REF TO cl_salv_table.

"Tabela de saida para o alv, para a visualização dos dados de pacientes
TYPES:
  BEGIN OF ty_pacientes,
    id_pac          TYPE ztbqv_pacientes-id_pac,
    nome            TYPE ztbqv_pacientes-nome,
    area_medica     TYPE ztbqv_pacientes-area_medica,
    data_nascimento TYPE ztbqv_pacientes-data_nascimento,
    consulta_conf   TYPE ztbqv_pacientes-consulta_conf,
    pagamento_conf  TYPE ztbqv_pacientes-pagamento_conf,
    valor           TYPE ztbqv_pacientes-valor,
    cad_em          TYPE ztbqv_pacientes-cad_em,
    cad_por         TYPE ztbqv_pacientes-cad_por,
    alterado_em     TYPE ztbqv_pacientes-alterado_em,
    alterado_por    TYPE ztbqv_pacientes-alterado_por,
  END OF ty_pacientes.

DATA: ti_pacientes TYPE TABLE OF ty_pacientes,
      st_pac       TYPE ty_pacientes.
