
REPORT zrqv_qualivida.

INCLUDE zrqv_qualivida_top."Declaração de variáveis globais.
INCLUDE zrqv_qualivida_scr."Tela de seleção, PBO, PAI
INCLUDE zrqv_qualivida_frm."Forms
INCLUDE zrqv_qualivida_cls."Classe local

"AT SELECTION-SCREEN OUTPUT.

START-OF-SELECTION.

  PERFORM busca_dados.
