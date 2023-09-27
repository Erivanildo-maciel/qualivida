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

    METHODS
      hotspot_click
        FOR EVENT hotspot_click
          OF cl_gui_alv_grid IMPORTING e_row_id
                                       e_column_id
                                       es_row_no.

ENDCLASS.

"Tabelas internas de médicos e de pacientes, e variáveis.
DATA: lt_area_medica     TYPE TABLE OF ztbqv_area_med,
      lt_medicos         TYPE TABLE OF ztbqv_medicos,
      st_medicos         TYPE ztbqv_medicos,
      lt_area_medica_n   TYPE TABLE OF ty_espec,
      st_area_medica     TYPE ztbqv_area_med,
      lt_pacientes       TYPE TABLE OF ty_pacientes, "ztbqv_pacientes,
      st_pacientes       TYPE ztbqv_pacientes,
      lo_grid_9000a      TYPE REF TO cl_gui_alv_grid,
      lo_grid_9000b      TYPE REF TO cl_gui_alv_grid,
      lo_grid_200        TYPE REF TO cl_gui_alv_grid,
      lo_container_200   TYPE REF TO cl_gui_custom_container,
      lo_container_9000a TYPE REF TO cl_gui_custom_container,
      lo_container_9000b TYPE REF TO cl_gui_custom_container,
      lo_event_grid      TYPE REF TO lcl_event_grid,
      lt_tool_bar        TYPE ui_functions,
      lv_okcode_9000     TYPE sy-ucomm,
      lv_okcode_200      TYPE sy-ucomm,
      lt_fieldcata       TYPE lvc_t_fcat,
      lt_fieldcat200     TYPE lvc_t_fcat,
      lt_fieldcatb       TYPE lvc_t_fcat,
      ls_layout          TYPE lvc_s_layo,
      ls_variant         TYPE disvariant,
      lv_salvou_item     TYPE char1.

CLASS lcl_event_grid IMPLEMENTATION.

  METHOD data_changed.

    LOOP AT er_data_changed->mt_good_cells ASSIGNING FIELD-SYMBOL(<fs_good_cells>).
      READ TABLE lt_pacientes ASSIGNING FIELD-SYMBOL(<fs_pacientes>) INDEX <fs_good_cells>-row_id.
      CASE <fs_good_cells>-fieldname.
        WHEN 'VALOR'.
          <fs_pacientes>-valor = <fs_good_cells>-value.
        WHEN ''.
        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.

  METHOD hotspot_click.

    READ TABLE lt_area_medica_n ASSIGNING FIELD-SYMBOL(<fs_area_medica_n>) INDEX e_row_id-index.

      IF sy-subrc = 0.

        SELECT especialidade
               nome
          FROM ztbqv_medicos
          INTO TABLE lt_medicos
         WHERE especialidade EQ <fs_area_medica_n>-especialidade.

      ENDIF.
  ENDMETHOD.

ENDCLASS.
