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
TYPE-POOLS: slis.

FORM busca_dados.

  FREE: lt_area_medica_n,
        lt_pacientes.

  "Consulta para retornar os dados da tabela de especialidades
  SELECT *
    FROM ztbqv_area_med
    INTO TABLE lt_area_medica
   WHERE especialidade IN so_area.

"Consulta para retornar os dados da tabela de pacientes
  SELECT *
    FROM ztbqv_pacientes
    INTO TABLE lt_pacientes
   WHERE area_medica IN so_area.

  "Percorre as tabelas para alterar as caracteríticas dos campos das tabelas.
  PERFORM configuration_of_tables.

  "Modo de Visualização alv básico ou completo.
  IF p_basic EQ 'X'.

    PERFORM show_alv_basico.

  ELSEIF p_compl EQ 'X'.

    PERFORM show_alv_completo.

  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form VISUALIZAR_DADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM show_alv_basico."Visualização de ALV básico

  IF lt_area_medica IS INITIAL.
    MESSAGE |Não exite atendimento para esta especialidade no momento!| TYPE 'S' DISPLAY LIKE 'W'.
    EXIT.
  ENDIF.

  DATA: lt_fieldcat_basico TYPE slis_t_fieldcat_alv,
        ls_layout_basico   TYPE slis_layout_alv.

  "Cria o it_fieldcat com base em uma estrutura de dados criada na SE11.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'ZTBQV_AREA_MED'
    CHANGING
      ct_fieldcat      = lt_fieldcat_basico[].

  ls_layout_basico-colwidth_optimize = 'X'. "Coloca as colunas com as larguras configuradas automaticamente
  ls_layout_basico-zebra = 'X'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      is_layout     = ls_layout_basico
      it_fieldcat   = lt_fieldcat_basico[]
    TABLES
      t_outtab      = lt_area_medica[] "Tabela interna de saída que contém os dados que serão mostrados no alv.
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SHOW_ALV_COMPLETO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM show_alv_completo .

  IF lt_area_medica IS NOT INITIAL AND lt_pacientes IS NOT INITIAL."verifica se as tabelas estão preenchidas.

    IF lv_salvou_item = 'X'.
      lo_grid_9000a->refresh_table_display( ).
      lo_grid_9000b->refresh_table_display( ).
    ELSE.
      CALL SCREEN 9000."Chamada da tela principal
    ENDIF.

  ELSE.

    MESSAGE |Dados não Localizados!| TYPE 'S' DISPLAY LIKE 'W'."Se não esxistir dados nas consultas, dispara a mensagem de erro.

  ENDIF.

ENDFORM.

"Parâmetros do fieldcat que são modificados no grid.
FORM f_build_fieldcat USING VALUE(p_fieldname) TYPE c
                            VALUE(p_field)     TYPE c
                            VALUE(p_table)     TYPE c
                            VALUE(p_coltext)   TYPE c
                            VALUE(p_emphasize) TYPE c
                            VALUE(p_just)      TYPE c
                            VALUE(p_edit)      TYPE c
                            VALUE(p_hotspot)   TYPE c
                            VALUE(p_do_sum)    TYPE c
                            VALUE(p_checkbox)  TYPE c
                         CHANGING t_fieldcat   TYPE lvc_t_fcat.

  DATA: ls_fieldcat LIKE LINE OF t_fieldcat[].
  ls_fieldcat-fieldname = p_fieldname.
  ls_fieldcat-ref_field = p_field.
  ls_fieldcat-ref_table = p_table.
  ls_fieldcat-coltext   = p_coltext.
  ls_fieldcat-emphasize = p_emphasize.
  ls_fieldcat-just      = p_just.
  ls_fieldcat-edit      = p_edit.
  ls_fieldcat-hotspot   = p_hotspot.
  ls_fieldcat-do_sum    = p_do_sum.
  ls_fieldcat-checkbox  = p_checkbox.
  APPEND ls_fieldcat TO t_fieldcat[].

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_BUILD_SORT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_build_sort  USING p_spos
                         p_name
                         p_up
                         p_down
                         p_group
                         p_subtot
                         p_expa.
  DATA: ls_sort LIKE LINE OF lt_sort[].
  ls_sort-spos      = p_spos.   "Não sei.
  ls_sort-fieldname = p_name.   "Campo de seleção do agrupamento.
  ls_sort-up        = p_up.     "Pelo maior valor.
  ls_sort-down      = p_down.   "Pelo menor valor.
  ls_sort-group     = p_group.  "Agrupar.
  ls_sort-subtot    = p_subtot. "Subtotal.
  ls_sort-expa      = p_expa.   "Expandido.
  APPEND ls_sort TO lt_sort.
ENDFORM.                    " F_BUILD_SORT

"Montagem do fieldcat do grid da tabela de Especialidades
FORM build_grid_a.


  PERFORM f_build_fieldcat USING:

  'ESPECIALIDADE' 'ESPECIALIDADE' 'ZTBQV_AREA_MED'  'Área Médica'  'C500'  '' '' 'X' ''  ''  CHANGING lt_fieldcata[],
  'DATA_INICIO'   'DATA_INICIO'   'ZTBQV_AREA_MED'  'Dt Início'    ''      '' '' ''  ''  ''  CHANGING lt_fieldcata[],
  'DATA_FIM'      'DATA_FIM'      'ZTBQV_AREA_MED'  'Dt Fim'       ''      '' '' ''  ''  ''  CHANGING lt_fieldcata[],
  'ATIVO'         'ATIVO'         'ZTBQV_AREA_MED'  'Status'       ''      '' '' ''  ''  ''  CHANGING lt_fieldcata[].

  IF lo_grid_9000a IS INITIAL.

    "Instância dos objetos
    lo_container_9000a = NEW cl_gui_custom_container( container_name = 'CONTAINERA' ).
    lo_grid_9000a      = NEW cl_gui_alv_grid( i_parent = lo_container_9000a ).
    lo_event_grid      = NEW lcl_event_grid( ).

    "Chamada de métodos
    lo_grid_9000a->set_ready_for_input( 1 )."Seleção múltipla de linhas
    lo_grid_9000a->set_table_for_first_display(
      EXPORTING
        is_variant           = ls_variant
        is_layout            = ls_layout
        i_save               = 'A'
        it_toolbar_excluding = lt_tool_bar[]
      CHANGING
        it_fieldcatalog      = lt_fieldcata[]
        it_outtab            = lt_area_medica_n[]
    ).

    lo_grid_9000a->set_gridtitle( 'Especialidades' )."Título do Grid de especialidades médicas
    SET HANDLER lo_event_grid->hotspot_click FOR lo_grid_9000a.
  ELSE.
    lo_grid_9000a->refresh_table_display( )."refresh da tela.
  ENDIF.

ENDFORM.

"Montagem do fieldcat do grid da tabela de pacientes
FORM build_grid_b.

  PERFORM f_build_sort USING:

    ''  'AREA_MEDICA'  'X'  ''  ''   'X'  ' ',
    ''  'VALOR'        'X'  ''  ''   ''  ' '.

  PERFORM f_build_fieldcat USING:

 'ID'              'ID'              'TY_PACIENTES'     'Status'           ''   'CENTER'  ''    ''  ''  ''  CHANGING lt_fieldcatb[],
 'ID_PAC'          'ID_PAC'          'ZTBQV_PACIENTES'  'Id. Paciente'     ''   ''        ''    ''  ''  ''  CHANGING lt_fieldcatb[],
 'NOME'            'NOME'            'ZTBQV_PACIENTES'  'Nome'             ''   'CENTER'  ''    ''  ''  ''  CHANGING lt_fieldcatb[],
 'AREA_MEDICA'     'AREA_MEDICA'     'ZTBQV_PACIENTES'  'Especialidade'    ''   'CENTER'  ''    ''  ''  ''  CHANGING lt_fieldcatb[],
 'DATA_NASCIMENTO' 'DATA_NASCIMENTO' 'ZTBQV_PACIENTES'  'Dt. Nascimento'   ''   'CENTER'  ''    ''  ''  ''  CHANGING lt_fieldcatb[],
 'CONSULTA_CONF'   'CONSULTA_CONF'   'ZTBQV_PACIENTES'  'Conf. Consulta'   ''   'CENTER'  'X'   ''  ''  'X' CHANGING lt_fieldcatb[],
 'PAGAMENTO_CONF'  'PAGAMENTO_CONF'  'ZTBQV_PACIENTES'  'Conf. Pagamento'  ''   'CENTER'  ''    ''  ''  ''  CHANGING lt_fieldcatb[],
 'VALOR'           'VALOR'           'ZTBQV_PACIENTES'  'Valor'            ''   ''        'X'   ''  'X' ''  CHANGING lt_fieldcatb[].

  IF lo_grid_9000b IS INITIAL.

    "Instância dos objetos
    lo_container_9000b = NEW cl_gui_custom_container( container_name = 'CONTAINERB' ).
    lo_grid_9000b      = NEW cl_gui_alv_grid( i_parent = lo_container_9000b ).
    lo_event_grid      = NEW lcl_event_grid( ).

    "Chamada de métodos
    lo_grid_9000b->set_ready_for_input( 1 )."Seleção múltipla de linhas

    "Permite alteração de dados no grid.
    lo_grid_9000b->register_edit_event(
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified
    ).

    lo_grid_9000b->set_table_for_first_display(
      EXPORTING
        is_variant           = ls_variant
        is_layout            = ls_layout
        i_save               = 'A'
        it_toolbar_excluding = lt_tool_bar[]
      CHANGING
        it_fieldcatalog      = lt_fieldcatb[]
        it_outtab            = lt_pacientes[]
        it_sort              = lt_sort[]
    ).

    lo_grid_9000b->set_gridtitle( 'Lista de Pacientes' )."Título do Grid de pacientes

    SET HANDLER lo_event_grid->data_changed FOR lo_grid_9000b.
  ELSE.
    lo_grid_9000b->refresh_table_display( )."refresh da tela.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form CONFIGURATION_OF_TABLES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM configuration_of_tables.

  FREE: lt_area_medica_n.
  DATA: ls_area_medica LIKE LINE OF lt_area_medica_n,
        ls_celltab     LIKE LINE OF ls_area_medica-celltab.
  FREE:ls_area_medica-celltab..

  "Percorre a tabela de especialidades para adicionar NEGRITO as colunas dt fim e dt inicio
  "De acordo com a lógica seguinte.
  LOOP AT lt_area_medica ASSIGNING FIELD-SYMBOL(<fs_negrito>)."FIELD-SYMBOL

    MOVE-CORRESPONDING <fs_negrito> TO ls_area_medica.

    IF ls_area_medica-ativo EQ 'A'.
      ls_celltab-fieldname = 'DATA_INICIO'.
      ls_celltab-style = '00000121'.
      INSERT ls_celltab INTO TABLE ls_area_medica-celltab.

      ls_celltab-fieldname = 'DATA_FIM'.
      ls_celltab-style = '00000121'.
      INSERT ls_celltab INTO TABLE ls_area_medica-celltab.
    ENDIF.

    APPEND ls_area_medica TO lt_area_medica_n.
  ENDLOOP.

  "Percorre a tabela de pacientes para adicionar Ícone de semáforos e cores nas linhas
  "de acordo com a cor do semáforo.
  LOOP AT lt_pacientes ASSIGNING FIELD-SYMBOL(<fs_pacientes>).

    IF <fs_pacientes>-consulta_conf IS NOT INITIAL AND <fs_pacientes>-pagamento_conf IS NOT INITIAL.

      IF <fs_pacientes>-valor IS NOT INITIAL.

        "Faz o procedimento padrão.
        <fs_pacientes>-id = icon_green_light.
        <fs_pacientes>-color = 'C500'.
      ELSE.
        "Atualiza o semáforo e a cor da linha de acordo com que os dados vão sendo atualizados no grid
        <fs_pacientes>-pagamento_conf = ''.
        <fs_pacientes>-id = icon_yellow_light.
        <fs_pacientes>-color = 'C300'.

      ENDIF.

    ELSEIF <fs_pacientes>-consulta_conf IS NOT INITIAL AND <fs_pacientes>-pagamento_conf IS INITIAL.
      "Atualiza o semáforo e a cor da linha de acordo com que os dados vão sendo atualizados no grid
      IF <fs_pacientes>-valor IS NOT INITIAL.
        <fs_pacientes>-pagamento_conf = 'X'.
        <fs_pacientes>-id = icon_green_light.
        <fs_pacientes>-color = 'C500'.
      ELSE.
        "Faz o procedimento padrão.
        <fs_pacientes>-id = icon_yellow_light.
        <fs_pacientes>-color = 'C300'.
      ENDIF.

    ELSEIF <fs_pacientes>-consulta_conf EQ '' AND <fs_pacientes>-pagamento_conf EQ ''.

      IF <fs_pacientes>-valor IS INITIAL.
        "Procedimento padrão
        <fs_pacientes>-id = icon_red_light.
        <fs_pacientes>-color = 'C600'.
      ELSE.
        "Atualiza o semáforo e a cor da linha de acordo com que os dados vão sendo atualizados no grid
        <fs_pacientes>-pagamento_conf = 'X'.
        <fs_pacientes>-id = icon_green_light.
        <fs_pacientes>-color = 'C500'.
      ENDIF.

    ELSEIF <fs_pacientes>-consulta_conf IS INITIAL.
      "Atualiza o semáforo e a cor da linha de acordo com que os dados vão sendo atualizados no grid
      IF <fs_pacientes>-valor IS NOT INITIAL.
        <fs_pacientes>-id = icon_yellow_light.
        <fs_pacientes>-color = 'C300'.
      ELSE.
        "Faz o procedimento padrão.
        <fs_pacientes>-id = icon_red_light.
        <fs_pacientes>-color = 'C600'.
      ENDIF.

    ENDIF.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form SALVAR_DADOS_ALTERADOS_NO_GRID
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

"Salva as alterações feitas no grid.
FORM salvar_alteracoes_grid.

  UPDATE ztbqv_pacientes FROM TABLE lt_pacientes.

  IF sy-subrc = 0.

    COMMIT WORK.
    lv_salvou_item = 'X'.

    SELECT *
      FROM ztbqv_pacientes
      INTO TABLE lt_pacientes
     WHERE area_medica IN so_area.

*    LOOP AT lt_pacientes_aux ASSIGNING FIELD-SYMBOL(<fs_pacientes_aux>).
*
*      "Altera os cores e o semáforo do grid de acorco com os dados que foram alterados.
*
*      IF <fs_pacientes_aux>-valor IS INITIAL AND <fs_pacientes_aux>-consulta_conf IS NOT INITIAL.
*
*        <fs_pacientes_aux>-pagamento_conf = ''.
*        <fs_pacientes_aux>-id = icon_yellow_light.
*        <fs_pacientes_aux>-color = 'C300'.
*
*      ELSEIF <fs_pacientes_aux>-valor IS INITIAL AND <fs_pacientes_aux>-consulta_conf IS INITIAL.
*
*        <fs_pacientes_aux>-pagamento_conf = ''.
*        <fs_pacientes_aux>-id = icon_red_light.
*        <fs_pacientes_aux>-color = 'C600'.
*
*      ELSEIF <fs_pacientes_aux>-consulta_conf IS INITIAL AND <fs_pacientes_aux>-valor IS NOT INITIAL.
*
*        MESSAGE |Para alterar valor a consulta tem que está confirmada!| TYPE 'W' DISPLAY LIKE 'E'.
*        LEAVE SCREEN.
*
*      ENDIF.
*
*      IF <fs_pacientes_aux>-valor IS NOT INITIAL AND <fs_pacientes_aux>-consulta_conf IS NOT INITIAL.
*
*        <fs_pacientes_aux>-pagamento_conf = 'X'.
*        <fs_pacientes_aux>-id = icon_green_light.
*        <fs_pacientes_aux>-color = 'C500'.
*
*      ELSEIF <fs_pacientes_aux>-consulta_conf IS INITIAL AND <fs_pacientes_aux>-valor IS INITIAL.
*
*        <fs_pacientes_aux>-id = icon_red_light.
*        <fs_pacientes_aux>-color = 'C600'.
*
*      ELSEIF <fs_pacientes_aux>-consulta_conf IS INITIAL AND <fs_pacientes_aux>-valor IS NOT INITIAL.
*
*        MESSAGE |Para inserir valor a consulta tem que está confirmada!| TYPE 'W' DISPLAY LIKE 'E'.
*        LEAVE SCREEN.
*
*      ENDIF.
*
*      IF <fs_pacientes_aux>-consulta_conf IS NOT INITIAL AND <fs_pacientes_aux>-valor IS INITIAL.
*
*        <fs_pacientes_aux>-id = icon_yellow_light.
*        <fs_pacientes_aux>-color = 'C300'.
*
*      ELSEIF <fs_pacientes_aux>-consulta_conf IS NOT INITIAL AND <fs_pacientes_aux>-valor IS NOT INITIAL.
*
*        <fs_pacientes_aux>-pagamento_conf = 'X'.
*        <fs_pacientes_aux>-id = icon_green_light.
*        <fs_pacientes_aux>-color = 'C500'.
*
*      ELSEIF <fs_pacientes_aux>-valor IS NOT INITIAL AND <fs_pacientes_aux>-consulta_conf IS INITIAL.
*
*        MESSAGE |Para inserir valor a consulta tem que está confirmada!| TYPE 'W' DISPLAY LIKE 'E'.
*        LEAVE SCREEN.
*
*      ENDIF.
*    ENDLOOP.
*
*    APPEND lt_pacientes_aux TO lt_pacientes.

    PERFORM reuse_alv_button."Remoção de botões da toolbar
    PERFORM build_grid_a."Montagem Grid de especialidades
    PERFORM build_grid_b."Montagem Grid de pacientes

    PERFORM show_alv_completo.

    MESSAGE |Dados salvos com sucesso!| TYPE 'S'.
  ELSE.
    ROLLBACK WORK.
    MESSAGE |Erro na alteração dos dados| TYPE 'S' DISPLAY LIKE 'W'.
  ENDIF.

ENDFORM.

"Os botões que estão comentados, são os que aparecem na toolbar.
FORM reuse_alv_button.

  "Remove os botões da toolbar.
  APPEND cl_gui_alv_grid=>mc_evt_delayed_change_select  TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_evt_delayed_move_curr_cell TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_evt_enter                  TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_evt_modified               TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_auf                     TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_average                 TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_back_classic            TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_call_abc                TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_call_chain              TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_call_crbatch            TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_call_crweb              TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_call_lineitems          TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_call_master_data        TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_call_more               TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_call_report             TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_call_xint               TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_call_xxl                TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_check                   TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_col_invisible           TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_col_optimize            TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_count                   TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_current_variant         TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_data_save               TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_delete_filter           TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_deselect_all            TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_detail                  TO lt_tool_bar.
*APPEND cl_gui_alv_grid=>mc_fc_excl_all                TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_expcrdata               TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_expcrdesig              TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_expcrtempl              TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_expmdb                  TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_extend                  TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_f4                      TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_filter                  TO lt_tool_bar.
*APPEND cl_gui_alv_grid=>mc_fc_find                    TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_fix_columns             TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_graph                   TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_help                    TO lt_tool_bar.
*APPEND cl_gui_alv_grid=>mc_fc_info                    TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_load_variant            TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_loc_append_row          TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_loc_copy                TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_loc_copy_row            TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_loc_cut                 TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_loc_delete_row          TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_loc_insert_row          TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_loc_move_row            TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_loc_paste               TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_loc_paste_new_row       TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_loc_undo                TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_maintain_variant        TO lt_tool_bar.
*APPEND cl_gui_alv_grid=>mc_fc_maximum                 TO lt_tool_bar.
*APPEND cl_gui_alv_grid=>mc_fc_minimum                 TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_pc_file                 TO lt_tool_bar.
*APPEND cl_gui_alv_grid=>mc_fc_print                   TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_print_back              TO lt_tool_bar.
  APPEND cl_gui_alv_grid=>mc_fc_print_prev              TO lt_tool_bar.
*APPEND cl_gui_alv_grid=>mc_fc_refresh                 TO lt_tool_bar.

ENDFORM.
