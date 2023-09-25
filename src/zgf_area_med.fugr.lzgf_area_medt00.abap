*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZTBQV_AREA_MED..................................*
DATA:  BEGIN OF STATUS_ZTBQV_AREA_MED                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTBQV_AREA_MED                .
CONTROLS: TCTRL_ZTBQV_AREA_MED
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZTBQV_AREA_MED                .
TABLES: ZTBQV_AREA_MED                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
