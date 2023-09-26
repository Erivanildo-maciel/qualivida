*&---------------------------------------------------------------------*
*& Include          ZRQV_QUALIVIDA_CLS
*&---------------------------------------------------------------------*
"Criação da classe local

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

ENDCLASS.
