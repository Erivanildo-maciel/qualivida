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
  DATA: lv_user   TYPE sy-uzeit,
        lv_cad_em TYPE sy-datum.

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

  UPDATE ztbqv_pacientes
     SET area_medica     = @ls_pacientes-area_medica,
         consulta_conf   = @ls_pacientes-consulta_conf,
         data_nascimento = @ls_pacientes-data_nascimento,
         nome            = @ls_pacientes-nome,
         pagamento_conf  = @ls_pacientes-pagamento_conf,
         valor           = @ls_pacientes-valor
   WHERE id_pac          = @ls_up_pacientes-id_pac.

  IF sy-subrc = 0.

    MESSAGE |Cadastro atualizado com sucesso!| TYPE 'S'.

  ELSE.

    MESSAGE |Falha na atualização do cadastro!| TYPE 'E'.

  ENDIF.

ENDFORM.
