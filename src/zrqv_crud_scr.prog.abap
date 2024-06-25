*&---------------------------------------------------------------------*
*& Include          ZRQV_CRUD_SCR
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module PBO_9000 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
AT SELECTION-SCREEN.
MODULE pbo_9000 OUTPUT.

  SET PF-STATUS 'GUI_SATAUS_9000'.
  IF sy-tcode = 'ZTQV_CAD_PAC'.
    SET TITLEBAR 'TITLE_9000'.
  ELSEIF sy-tcode = 'ZTQV_UP_PAC'.
    SET PF-STATUS 'GUI_SATAUS_9002'.
    SET TITLEBAR 'TITLE_9001'.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  PAI_9000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE pai_9000 INPUT.

  CASE sy-ucomm.
    WHEN 'SAVE'.
      IF sy-tcode = 'ZTQV_CAD_PAC'.
        PERFORM salvar_dados.
      ELSEIF sy-tcode = 'ZTQV_UP_PAC'.
        PERFORM atualizar_dados.
      ENDIF.

    WHEN '&F03'.
      LEAVE TO SCREEN 0.
    WHEN '&F15'.
      LEAVE TO SCREEN 0.
    WHEN '&F12'.
      LEAVE PROGRAM.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module PBO_9001 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE pbo_9001 OUTPUT.
  SET PF-STATUS 'GUI_SATAUS_9001'.
  SET TITLEBAR 'TITLE_9001'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  PAI_9001  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE pai_9001 INPUT.
  CASE sy-ucomm.
    WHEN 'EXEC' OR ''.
      PERFORM buscar_dados_id.
    WHEN '&F03'.
      LEAVE TO SCREEN 0.
    WHEN '&F15'.
      LEAVE TO SCREEN 0.
    WHEN '&F12'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module PBO_9002 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE pbo_9002 OUTPUT.
  SET PF-STATUS 'GUI_SATAUS_9002'.
  SET TITLEBAR 'TITLE_9002'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  PAI_9002  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE pai_9002 INPUT.
  CASE sy-ucomm.
    WHEN 'EXEC'.
      PERFORM exibir_dados_id.
    WHEN '&F03'.
      LEAVE TO SCREEN 0.
    WHEN '&F15'.
      LEAVE TO SCREEN 0.
    WHEN '&F12'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
