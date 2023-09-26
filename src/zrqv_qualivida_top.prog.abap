*&---------------------------------------------------------------------*
*& Include          ZRQV_QUALIVIDA_TOP
*&---------------------------------------------------------------------*
INCLUDE <icon>.

TYPES: BEGIN OF ty_pacientes.
         INCLUDE TYPE ztbqv_pacientes.
         TYPES: id TYPE icon-id,
       END OF ty_pacientes.

DATA: lt_pac TYPE TABLE OF ty_pacientes,
      st_pac TYPE ty_pacientes.


"Tabelas internas de médicos e de pacientes, e variáveis.
DATA: lt_area_medica     TYPE TABLE OF ztbqv_area_med,
      st_area_medica     TYPE ztbqv_area_med,
      lt_pacientes       TYPE TABLE OF ty_pacientes, "ztbqv_pacientes,
      st_pacientes       TYPE ztbqv_pacientes,
      lo_grid_9000a      TYPE REF TO cl_gui_alv_grid,
      lo_grid_9000b      TYPE REF TO cl_gui_alv_grid,
      lo_container_9000a TYPE REF TO cl_gui_custom_container,
      lo_container_9000b TYPE REF TO cl_gui_custom_container,
      lt_tool_bar        TYPE ui_functions,
      lv_okcode_9000     TYPE sy-ucomm,
      lt_fieldcata       TYPE lvc_t_fcat,
      lt_fieldcatb       TYPE lvc_t_fcat,
      ls_layout          TYPE lvc_s_layo,
      ls_variant         TYPE disvariant.
