*&---------------------------------------------------------------------*
*& Include          ZRQV_QUALIVIDA_TOP
*&---------------------------------------------------------------------*
INCLUDE <icon>.

TYPES: BEGIN OF ty_pacientes.
         INCLUDE TYPE ztbqv_pacientes.
         TYPES: id    TYPE icon-id,
         color TYPE char4,
       END OF ty_pacientes,

       BEGIN OF ty_espec.
         INCLUDE TYPE ztbqv_area_med.
         TYPES: celltab TYPE lvc_t_styl,
       END OF ty_espec.

DATA: lt_pac TYPE TABLE OF ty_pacientes,
      st_pac TYPE ty_pacientes.

"Criacção da classe local de eventos
CLASS lcl_event_grid DEFINITION.
  PUBLIC SECTION.
    METHODS
      data_changed
        FOR EVENT data_changed
          OF cl_gui_alv_grid IMPORTING er_data_changed
                                       e_onf4
                                       e_onf4_before
                                       e_onf4_after
                                       e_ucomm.
ENDCLASS.

"Tabelas internas de médicos e de pacientes, e variáveis.
DATA: lt_area_medica     TYPE TABLE OF ztbqv_area_med,
      lt_area_medica_n   TYPE TABLE OF ty_espec,
      st_area_medica     TYPE ztbqv_area_med,
      lt_pacientes       TYPE TABLE OF ty_pacientes, "ztbqv_pacientes,
      st_pacientes       TYPE ztbqv_pacientes,
      lo_grid_9000a      TYPE REF TO cl_gui_alv_grid,
      lo_grid_9000b      TYPE REF TO cl_gui_alv_grid,
      lo_container_9000a TYPE REF TO cl_gui_custom_container,
      lo_container_9000b TYPE REF TO cl_gui_custom_container,
      lo_event_grid      TYPE REF TO lcl_event_grid,
      lt_tool_bar        TYPE ui_functions,
      lv_okcode_9000     TYPE sy-ucomm,
      lt_fieldcata       TYPE lvc_t_fcat,
      lt_fieldcatb       TYPE lvc_t_fcat,
      ls_layout          TYPE lvc_s_layo,
      ls_variant         TYPE disvariant.
