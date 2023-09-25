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
