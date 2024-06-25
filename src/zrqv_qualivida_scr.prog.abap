*&---------------------------------------------------------------------*
*& Include          ZRQV_QUALIVIDA_SCR
*&---------------------------------------------------------------------*

*Declaração de tabelas.
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
MODULE pbo_9000 OUTPUT."PBO tela  principal

  SET PF-STATUS 'STATUS_9000'.
  SET TITLEBAR  'TITLE_9000'.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  PAI_9000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE pai_9000 INPUT."PAI tela principal

  CASE lv_okcode_9000.
    WHEN 'BACK' OR '&F03' OR '&F15'.
      LEAVE TO SCREEN 0.
      CLEAR lv_salvou_item.
    WHEN 'EXIT' OR '&F12'.
      LEAVE PROGRAM.
      CLEAR lv_salvou_item.
    WHEN 'SAVE'.
      PERFORM salvar_alteracoes_grid."Chamada do form para salvar os dados editados no grid.
      PERFORM busca_dados.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.


*&---------------------------------------------------------------------*
*& Module SHOW_GRID_9000 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE show_grid_9000 OUTPUT."Módulo com a para a exibição dos grids

  FREE lt_fieldcata.
  ls_layout-cwidth_opt = 'X'.
  ls_layout-stylefname = 'CELLTAB'.
  ls_layout-zebra      = 'X'.
  ls_layout-info_fname = 'COLOR'.
  ls_variant-report    = sy-repid.

  PERFORM reuse_alv_button."Remoção de botões da toolbar
  PERFORM build_grid_a."Montagem Grid de especialidades
  PERFORM build_grid_b."Montagem Grid de pacientes

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT."PBO da tela que exibirá o popup com os dados de médicos

  SET PF-STATUS 'STATUS200'.
  SET TITLEBAR 'TITLE200'.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT."PAI da tela 200

  CASE lv_okcode_200.
    WHEN 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module SHOW_SCREEN_200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

"Montagem do fieldcat da tabela de medicos
MODULE show_screen_200 OUTPUT.

  FREE: lt_fieldcat200.

  ls_layout200-zebra = 'X'.
  ls_layout200-cwidth_opt = 'X'.

  PERFORM f_build_fieldcat USING:

  'NOME'          'NOME'          'ZTBQV_MEDICOS'  'Médico'         ''  '' '' '' '' '' CHANGING lt_fieldcat200[],
  'ESPECIALIDADE' 'ESPECIALIDADE' 'ZTBQV_MEDICOS'  'Especialidade'  ''  '' '' '' '' '' CHANGING lt_fieldcat200[].

  IF lo_grid_200 IS INITIAL.

    "Instâncias dos objetos
    lo_container_200   = NEW cl_gui_custom_container( container_name = 'CONTAINER200' ).
    lo_grid_200        = NEW cl_gui_alv_grid( i_parent = lo_container_200 ).

    "Chamada de métodos
    lo_grid_200->set_ready_for_input( 1 )."Seleção múltipla de linhas
    lo_grid_200->set_table_for_first_display(
      EXPORTING
        is_variant           = ls_variant
        is_layout            = ls_layout
        i_save               = 'A'
        it_toolbar_excluding = lt_tool_bar[]
      CHANGING
        it_fieldcatalog      = lt_fieldcat200[]
        it_outtab            = lt_medicos[]
    ).

    lo_grid_200->set_gridtitle( 'lista de médicos' )."Título da tela de lista de médicos
  ELSE.
    lo_grid_200->refresh_table_display( )."Refresh da tela
  ENDIF.

ENDMODULE.
