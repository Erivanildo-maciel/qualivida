*&---------------------------------------------------------------------*
*& Include          ZRQV_QUALIVIDA_SCR
*&---------------------------------------------------------------------*

TABLES: ztbqv_area_med.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
  SELECT-OPTIONS: so_area FOR ztbqv_area_med-especialidade NO INTERVALS.
SELECTION-SCREEN END OF BLOCK b1.
