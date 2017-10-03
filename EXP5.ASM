DATA    SEGMENT
BUF     DB      12H,56H,9DH,0D7H,0,45H,78H,89H,0F5H,6AH
COUNT   EQU     $-BUF
MAX     DB      ?
DATA    ENDS
CODE    SEGMENT
        ASSUME  CS:CODE,DS:DATA
START:  MOV     AX,DATA
        MOV     DS,AX
        MOV     CX,COUNT-1
        MOV     BX,OFFSET BUF
        MOV     AL,[BX]
AGAIN:  INC     BX
        CMP     AL,[BX]
        JGE     NEXT
        MOV     AL,[BX]
NEXT:   LOOP    AGAIN
        MOV     MAX,AL
        MOV     BL,AL
        MOV     CH,2
        MOV     CL,4
ROTATE: ROR     BL,CL
        MOV     AL,BL
        AND     AL,0FH
        ADD     AL,30H
        CMP     AL,3AH
        JL      PRINTIT
        ADD     AL,7
PRINTIT:MOV     DL,AL
        MOV     AH,2
        INT     21H
        DEC     CH
        JNZ     ROTATE
        MOV     AH,2
        MOV     DL,48H
        INT     21H
        MOV     AH,4CH
        INT     21H
CODE    ENDS
        END     START

