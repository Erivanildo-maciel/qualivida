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
    WHEN 'BACK' OR '&F03' OR '&F15'.
      LEAVE TO SCREEN 0.
      CLEAR lv_salvou_item.
    WHEN 'EXIT' OR '&F12'.
      LEAVE PROGRAM.
      CLEAR lv_salvou_item.
    WHEN 'SAVE'.

      PERFORM salvar_alteracoes_grid.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.


*&---------------------------------------------------------------------*
*& Module SHOW_GRID_9000 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE show_grid_9000 OUTPUT.

  FREE lt_fieldcata.
  ls_layout-cwidth_opt = 'X'.
  ls_layout-stylefname = 'CELLTAB'.
  ls_layout-zebra      = 'X'.
  ls_layout-info_fname = 'COLOR'.
  ls_variant-report    = sy-repid.

  PERFORM reuse_alv_button.
  PERFORM build_grid_a.
  PERFORM build_grid_b.

ENDMODULE.
