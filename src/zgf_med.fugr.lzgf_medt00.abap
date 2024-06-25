*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZTBQV_MEDICOS...................................*
DATA:  BEGIN OF STATUS_ZTBQV_MEDICOS                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTBQV_MEDICOS                 .
CONTROLS: TCTRL_ZTBQV_MEDICOS
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZTBQV_MEDICOS                 .
TABLES: ZTBQV_MEDICOS                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
