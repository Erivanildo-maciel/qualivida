*&---------------------------------------------------------------------*
*& Include          ZRQV_CRUD_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form SALVAR_DADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM salvar_dados.
  "Váriavel para receber o ID da Função Numbe_get_next
  DATA: lv_prx_id TYPE i.

  "Váriáveis para salvar o usuário e a data no ato do cadastro
  DATA: lv_user   TYPE sy-uname,
        lv_cad_em TYPE sy-datum.

  lv_user   = sy-uname.
  lv_cad_em = sy-datum.

  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr             = 'ID'
      object                  = 'ZPACIENTES'
    IMPORTING
      number                  = lv_prx_id
    EXCEPTIONS
      interval_not_found      = 1
      number_range_not_intern = 2
      object_not_found        = 3
      quantity_is_0           = 4
      quantity_is_not_1       = 5
      interval_overflow       = 6
      buffer_overflow         = 7
      OTHERS                  = 8.

  IF sy-subrc = 0.
    ls_pacientes-id_pac = lv_prx_id.
  ELSE.
    MESSAGE |Erro na geração do ID!| TYPE 'E' DISPLAY LIKE 'S'.
    LEAVE TO SCREEN 9000.
  ENDIF.

  ls_pacientes-cad_em  = lv_cad_em.
  ls_pacientes-cad_por = lv_user.

  "Alimenta a tabela transparente apartir dos dados da tela de cadstro
  INSERT ztbqv_pacientes FROM ls_pacientes.

  IF sy-subrc = 0.

    MESSAGE |Paciente Cadastrado com sucesso!| TYPE 'S'.

  ELSE.

    MESSAGE |Erro no cadastro do paciente!| TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form BUSCAR_DADOS_ID
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM buscar_dados_id .

  SELECT SINGLE *
    FROM ztbqv_pacientes
    INTO ls_pacientes
  WHERE id_pac = ls_up_pacientes-id_pac.

  IF sy-subrc = 0.
    CALL SCREEN 9000.
  ELSE.
    MESSAGE |Paciente não encontrado para o ID informado!| TYPE 'I' DISPLAY LIKE 'E'.
    SET SCREEN 9001.
    LEAVE SCREEN.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ATUALIZAR_DADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM atualizar_dados .

  DATA: lv_up_por TYPE sy-uname,
        lv_up_em  TYPE sy-datum.

  lv_up_por = sy-uname.
  lv_up_em  = sy-datum.

  ls_pacientes-alterado_por = lv_up_por.
  ls_pacientes-alterado_em  = lv_up_em.

  UPDATE ztbqv_pacientes
     SET area_medica     = @ls_pacientes-area_medica,
         consulta_conf   = @ls_pacientes-consulta_conf,
         data_nascimento = @ls_pacientes-data_nascimento,
         nome            = @ls_pacientes-nome,
         pagamento_conf  = @ls_pacientes-pagamento_conf,
         valor           = @ls_pacientes-valor,
         alterado_por    = @ls_pacientes-alterado_por,
         alterado_em     = @ls_pacientes-alterado_em
   WHERE id_pac          = @ls_up_pacientes-id_pac.

  IF sy-subrc = 0.

    MESSAGE |Cadastro atualizado com sucesso!| TYPE 'S'.

  ELSE.

    MESSAGE |Falha na atualização do cadastro!| TYPE 'E'.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form EXIBIR_DADOS_ID
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM exibir_dados_id .

  SELECT
    id_pac
    nome
    area_medica
    data_nascimento
    consulta_conf
    pagamento_conf
    valor
    cad_em
    cad_por
    alterado_em
    alterado_por

    FROM ztbqv_pacientes
    INTO TABLE ti_pacientes
   WHERE id_pac EQ ls_pacientes-id_pac.

  IF sy-subrc <> 0.
    MESSAGE |Não foram encontrados dados para o id ({ ls_pacientes-id_pac })| TYPE 'I'.
  ENDIF.


  CALL METHOD cl_salv_table=>factory
    IMPORTING
      r_salv_table = ir_alv
    CHANGING
      t_table      = ti_pacientes.

  PERFORM catalogo_campos.

  ir_alv->display( ).

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CATALOGO_CAMPOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM catalogo_campos .

  DATA: o_columns TYPE REF TO cl_salv_columns,
        o_column  TYPE REF TO cl_salv_column.

  o_columns = ir_alv->get_columns( ).
  o_columns->set_optimize( 'X' ).

  o_column = o_columns->get_column( 'ID_PAC' ). " 01 ID do Paciente
  o_column->set_short_text(  'Id' ).
  o_column->set_medium_text( 'Id pac' ).
  o_column->set_long_text(   'Id paciente' ).
  o_column->set_output_length( 10 ).

  o_column = o_columns->get_column( 'NOME' ). " 02 Nome do paciente
  o_column->set_short_text(  'Nome' ).
  o_column->set_medium_text( 'Paciente' ).
  o_column->set_long_text(   'Nome do Paciente' ).
  o_column->set_output_length( 25 ).

  o_column = o_columns->get_column( 'AREA_MEDICA' ). "03 Especialidade médica
  o_column->set_short_text(  'Área' ).
  o_column->set_medium_text( 'Especialidade' ).
  o_column->set_long_text(   'Especialidade Médica' ).
  o_column->set_output_length( 30 ).

  o_column = o_columns->get_column( 'DATA_NASCIMENTO' ). "04 Confirmação de consulta
  o_column->set_short_text(  'DT. Nasc' ).
  o_column->set_medium_text( 'Data. Nasc' ).
  o_column->set_long_text(   'Data de nascimento' ).
  o_column->set_output_length( 10 ).

  o_column = o_columns->get_column( 'CONSULTA_CONF' ). "05 Confirmação de pagamento
  o_column->set_short_text(  'Conf.' ).
  o_column->set_medium_text( 'Conf. Consulta' ).
  o_column->set_long_text(   'Confirmação de Consulta' ).
  o_column->set_output_length( 1 ).

  o_column = o_columns->get_column( 'PAGAMENTO_CONF' ). "06 Confirmação de pagamento
  o_column->set_short_text(  'Pag' ).
  o_column->set_medium_text( 'Conf. Pag' ).
  o_column->set_long_text(   'Confirmação de Pagamento' ).
  o_column->set_output_length( 1 ).

  o_column = o_columns->get_column( 'VALOR' ). "07 Valor de consulta
  o_column->set_short_text(  'Valor' ).
  o_column->set_medium_text( 'Valor' ).
  o_column->set_long_text(   'Valor da consulta' ).
  o_column->set_output_length( 10 ).

  o_column = o_columns->get_column( 'CAD_EM' ). "08 Cadastrado em
  o_column->set_short_text(  'Cad. em' ).
  o_column->set_medium_text( 'cad. em' ).
  o_column->set_long_text(   'Cadastrado em' ).
  o_column->set_output_length( 10 ).

  o_column = o_columns->get_column( 'CAD_POR' ). "09 Cadastrado por
  o_column->set_short_text(  'Cad. Por' ).
  o_column->set_medium_text( 'Cad. Por' ).
  o_column->set_long_text(   'Cadastrado por' ).
  o_column->set_output_length( 25 ).

  o_column = o_columns->get_column( 'ALTERADO_EM' ). "10 Cadastrado em
  o_column->set_short_text(  'Alt. em' ).
  o_column->set_medium_text( 'Alt. em' ).
  o_column->set_long_text(   'Alterado em' ).
  o_column->set_output_length( 10 ).

  o_column = o_columns->get_column( 'ALTERADO_POR' ). "11 Cadastrado em
  o_column->set_short_text(  'Alt. por' ).
  o_column->set_medium_text( 'Alt. por' ).
  o_column->set_long_text(   'Alterado por' ).
  o_column->set_output_length( 25 ).

ENDFORM.
