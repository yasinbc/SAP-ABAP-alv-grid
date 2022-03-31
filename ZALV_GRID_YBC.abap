*&---------------------------------------------------------------------*
*& Report ZALV_GRID_YBC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZALV_GRID_YBC.

type-pools: slis. "para versiones anteriores a 7.40

types: BEGIN OF ty_bseg,
        bukrs_it type bseg-bukrs,
        belnr_it type bseg-belnr,
        gjahr_it type bseg-gjahr,
        werks_it type bseg-werks,
        wrbtr_it type bseg-wrbtr,
       END OF ty_bseg.

"Tabla con los datos:
data: it_bseg type STANDARD TABLE OF ty_bseg,
      it_bkpf TYPE STANDARD TABLE OF bkpf.

"Tabla fieldcat (define campos de la tabla)
DATA: it_fcat TYPE STANDARD TABLE OF slis_fieldcat_alv,
      wa_fcat TYPE slis_fieldcat_alv.

DATA: wa_layout TYPE slis_layout_alv,
      vl_variant TYPE disvariant.

REFRESH: it_fcat, it_bkpf, it_bseg.

"Armar fieldcat (definir columnas del ALV)
CLEAR: wa_fcat.
wa_fcat-fieldname = 'BUKRS_IT'.
wa_fcat-ref_tabname = 'BSEG'.
wa_fcat-ref_fieldname = 'BUKRS'.
wa_fcat-key = 'X'.
APPEND wa_fcat TO it_fcat.

CLEAR: wa_fcat.
wa_fcat-fieldname = 'BELNR_IT'.
wa_fcat-outputlen = 10.
wa_fcat-seltext_s = 'Nº doc.'.
wa_fcat-seltext_m = TEXT-002.
wa_fcat-seltext_l = TEXT-002.
wa_fcat-key = 'X'.
wa_fcat-no_zero = 'X'.
APPEND wa_fcat TO it_fcat.

CLEAR: wa_fcat.
wa_fcat-fieldname = 'GJAHR_IT'.
wa_fcat-ref_tabname = 'BSEG'.
wa_fcat-ref_fieldname = 'GJAHR'.
APPEND wa_fcat TO it_fcat.

CLEAR: wa_fcat.
wa_fcat-fieldname = 'WERKS_IT'.
wa_fcat-ref_tabname = 'BSEG'.
wa_fcat-ref_fieldname = 'WERKS'.
APPEND wa_fcat TO it_fcat.


SELECT bukrs belnr gjahr werks wrbtr
  FROM bseg
  INTO TABLE it_bseg.

SELECT * FROM bkpf
  INTO TABLE it_bkpf.

*"Layout
*CLEAR wa_layout.
*wa_layout-colwidth_optimize = 'X'.
*wa_layout-zebra = 'X'.
*
*"Variante
*vl_variant-report = 'ZALV_GRID_YBC'.


CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
*   I_INTERFACE_CHECK                 = ' '
*   I_BYPASSING_BUFFER                = ' '
*   I_BUFFER_ACTIVE                   = ' '
*   I_CALLBACK_PROGRAM                = ' '
*   I_CALLBACK_PF_STATUS_SET          = ' '
*   I_CALLBACK_USER_COMMAND           = ' '
*   I_CALLBACK_TOP_OF_PAGE            = ' '
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
*   I_STRUCTURE_NAME                  =
*   I_BACKGROUND_ID                   = ' '
*   I_GRID_TITLE                      =
*   I_GRID_SETTINGS                   =
*   IS_LAYOUT                         =
   IT_FIELDCAT                       = it_fcat
*   IT_EXCLUDING                      =
*   IT_SPECIAL_GROUPS                 =
*   IT_SORT                           =
*   IT_FILTER                         =
*   IS_SEL_HIDE                       =
*   I_DEFAULT                         = 'X'
*   I_SAVE                            = ' '
*   IS_VARIANT                        =
*   IT_EVENTS                         =
*   IT_EVENT_EXIT                     =
*   IS_PRINT                          =
*   IS_REPREP_ID                      =
*   I_SCREEN_START_COLUMN             = 0
*   I_SCREEN_START_LINE               = 0
*   I_SCREEN_END_COLUMN               = 0
*   I_SCREEN_END_LINE                 = 0
*   I_HTML_HEIGHT_TOP                 = 0
*   I_HTML_HEIGHT_END                 = 0
*   IT_ALV_GRAPHICS                   =
*   IT_HYPERLINK                      =
*   IT_ADD_FIELDCAT                   =
*   IT_EXCEPT_QINFO                   =
*   IR_SALV_FULLSCREEN_ADAPTER        =
*   O_PREVIOUS_SRAL_HANDLER           =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER           =
*   ES_EXIT_CAUSED_BY_USER            =
  TABLES
    t_outtab                          = it_bseg
 EXCEPTIONS
   PROGRAM_ERROR                     = 1
   OTHERS                            = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.