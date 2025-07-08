     FEGRATEDSP CF   E             WORKSTN SFILE(EGSFLDSP:RRN)
     FEGRATE00  UF A E           k DISK
     FEGPARA00  UF   E           K DISK
      *
     DRRN              S              4S 0
      *
        /FREE
            EXSR $MAIN;
            dow *in03 = *off;
                write FOOTER;
                EXFMT EGSFLCTRL;
                READC EGSFLDSP;
                select;
                    when (*in06 = *on);
                       EXSR $ADDAPPROVAL;
                    other;

                endsl;
            enddo;
            *INLR = *ON;
        /END-FREE
        /FREE
                BEGSR $MAIN;
                    EXSR $CLEARSFL;
                    EXSR LOADSFL;
                ENDSR;
            /END-FREE
      *
        /FREE
            BEGSR $CLEARSFL;
                *IN50 = *OFF;
                *IN51 = *OFF;
                WRITE EGSFLCTRL;
                RRN = 0;
                *IN50 = *ON;
            ENDSR;
        /END-FREE
      *
        /FREE
            BEGSR LOADSFL;
                SETLL *loval EGRATE00;
                READ EGRATE00;
                DOW NOT %EOF(EGRATE00);
                    RRN = RRN+1;
                    WRITE EGSFLDSP;
                    READ EGRATE00;
                ENDDO;
            ENDSR;
        /END-FREE
      *
        /FREE
            BEGSR $ADDAPPROVAL;
                DOW *IN03 = *OFF;
                    EXFMT DETAIL;
                    DSPLY APPRATE1;
                ENDDO;
                *IN03 = *OFF;

            ENDSR;
        /END-FREE
      *
        /FREE
            BEGSR $ADDAPPROVAL1;
                DOW *IN03 = *OFF;
                    EXFMT DETAIL;
                    DSPLY APPRATE1;
                ENDDO;
                *IN03 = *OFF;

            ENDSR;
        /END-FREE


