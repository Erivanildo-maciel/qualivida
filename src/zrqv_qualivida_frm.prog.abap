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
FORM busca_dados .

  SELECT *
    FROM ztbqv_area_med
    INTO TABLE lt_area_medica
   WHERE especialidade IN so_area.

  SELECT *
    FROM ztbqv_pacientes
    INTO TABLE lt_pacientes
   WHERE area_edica IN so_area.

ENDFORM.
