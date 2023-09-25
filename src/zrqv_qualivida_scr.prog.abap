*&---------------------------------------------------------------------*
*& Include          ZRQV_QUALIVIDA_SCR
*&---------------------------------------------------------------------*

TABLES: ztbqv_area_med.

*Tela de seleção com parâmetro Área Médica
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

SELECTION-SCREEN SKIP."Espaço entre as telas
SELECT-OPTIONS: so_area FOR ztbqv_area_med-especialidade NO INTERVALS.

SELECTION-SCREEN SKIP."Espaço entre as telas

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002."Selecionar modo de visualização do relatório.
PARAMETERS: p_basic TYPE char1 RADIOBUTTON GROUP gr1, "ALV Básico
            p_compl TYPE char1 RADIOBUTTON GROUP gr1 DEFAULT 'X'. "ALV Completo
SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN END OF BLOCK b1.
*&---------------------------------------------------------------------*
*& Module PBO_9000 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE pbo_9000 OUTPUT.

  SET PF-STATUS 'STATUS_9000'.
  SET TITLEBAR  'TITLE_9000'.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  PAI_9000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE pai_9000 INPUT.

  CASE lv_okcode_9000.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module SHOW_GRID_9000 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE show_grid_9000 OUTPUT.

  FREE lt_fieldcat.
  ls_layout-cwidth_opt = 'X'.
  ls_layout-zebra      = 'X'.
  ls_variant-report    = sy-repid.

  PERFORM f_build_fieldcat USING:
        'ESPECIALIDADE' 'ESPECIALIDADE'  'ZTBQV_AREA_MED'  'Área Médica'  CHANGING lt_fieldcat[],
        'DATA_INICIO'   'DATA_INICIO'    'ZTBQV_AREA_MED'  'Dt Início'    CHANGING lt_fieldcat[],
        'DATA_FIM'      'DATA_FIM'       'ZTBQV_AREA_MED'  'Dt Fim'       CHANGING lt_fieldcat[],
        'ATIVO'         'ATIVO'          'ZTBQV_AREA_MED'  'Status'       CHANGING lt_fieldcat[].


  IF lo_grid_9000 IS INITIAL.

    lo_grid_9000 = NEW cl_gui_alv_grid( i_parent = cl_gui_custom_container=>default_screen ).

    lo_grid_9000->set_table_for_first_display(
      EXPORTING
        is_variant      = ls_variant
        is_layout       = ls_layout
        i_save          = 'A'
      CHANGING
        it_fieldcatalog = lt_fieldcat[]
        it_outtab       = lt_area_medica[]
    ).
  ELSE.
    lo_grid_9000->refresh_table_display( ).
  ENDIF.






ENDMODULE.
