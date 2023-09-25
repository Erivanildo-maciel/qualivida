*&---------------------------------------------------------------------*
*& Include          ZRQV_QUALIVIDA_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form BUSCA_DADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
TYPE-POOLS: slis.

FORM busca_dados.

  "Consulta para retornar os dados da tabela de especialidades
  SELECT *
    FROM ztbqv_area_med
    INTO TABLE lt_area_medica
   WHERE especialidade IN so_area.

  "Validação da tela de seleção.
  IF p_basic EQ 'X'.

    IF lt_area_medica IS NOT INITIAL.

      PERFORM show_alv_basico.

    ELSE.

      MESSAGE |Não temos atendimento para essa área no momento!| TYPE 'S' DISPLAY LIKE 'E'.
      EXIT.

    ENDIF.

  ELSEIF p_compl EQ 'X'.

    IF lt_area_medica IS NOT INITIAL.

      PERFORM show_alv_completo.

    ELSE.

      MESSAGE |Não temos atendimento para essa área no momento!| TYPE 'S' DISPLAY LIKE 'E'.
      EXIT.

    ENDIF.

  ENDIF.


*  SELECT *
*    FROM ztbqv_pacientes
*    INTO TABLE lt_pacientes
*   WHERE area_medica IN so_area.
*
*  IF lt_pacientes IS INITIAL.
*    MESSAGE |Não existe paciente agendado para essa área!| TYPE 'S' DISPLAY LIKE 'E'.
*    EXIT.
*  ELSE.
*    PERFORM show_alv_basico.
*  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form VISUALIZAR_DADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM show_alv_basico."Visualização de ALV básico

  DATA: lt_fieldcat_basico TYPE slis_t_fieldcat_alv,
        ls_layout_basico   TYPE slis_layout_alv.

  "Cria o it_fieldcat[] com base em uma estrutura de dados criada na SE11.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'ZTBQV_AREA_MED'
    CHANGING
      ct_fieldcat      = lt_fieldcat_basico[].

  ls_layout_basico-colwidth_optimize = 'X'. "SIGGA56 - Coloca as colunas com as larguras configuradas automaticamente
  ls_layout_basico-zebra = 'X'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      is_layout     = ls_layout_basico
      it_fieldcat   = lt_fieldcat_basico[]
    TABLES
      t_outtab      = lt_area_medica[] "Tabela interna de saída. (Retorno dos dados)
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SHOW_ALV_COMPLETO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM show_alv_completo .

  IF lt_area_medica IS NOT INITIAL AND lt_pacientes IS NOT INITIAL.

    CALL SCREEN 9000.

  ELSE.

    MESSAGE |Dados não Localizados!| TYPE 'S' DISPLAY LIKE 'W'.

  ENDIF.
ENDFORM.
