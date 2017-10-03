
DATA SEGMENT
SUM DW 6000
SE DW 12
SHW DW 15
SHI DW 10
DAYNUM DW 102,90,67,89,98,125
MESS1 DB 10,13,'please input the six nums:',10,13,'$'
MESS2 DB  10,13,'your salary is:','$'
DATA ENDS
STACK SEGMENT 'STACK'
DW 100 DUP(?)
STACK ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA,SS:STACK
START:
  MOV AX,DATA
  MOV DS,AX
  
  CALL P1;调用子程序P1->计算程序
  CALL P2;调用显示子程序->十进制显示在屏幕
   MOV AH,4CH
   INT 21H
  

P1 PROC NEAR
   MOV CX,6
   LEA BX,DAYNUM;首字符地址付给BX
   
ONE:MOV AX,[BX]
    CMP AX,80
    JBE TWO;<=80时调到two
    SUB AX,80
    MUL SHW;多出的个数乘以15->(DX AX);超额工资不会超过65535,DX不用管
    ADD AX,SUM;超额工资不会超过65535,DX不用管
    MOV SUM,AX
    ADD BX,2
    LOOP ONE
    JMP FIN
TWO:MOV DX,80
    SUB DX,AX
    MOV AX,DX
    MUL SE;超额工资不会超过65535,DX不用管
    MOV DX,SUM
    SUB DX,AX
    MOV SUM,DX
    ADD BX,2
    LOOP ONE
    JMP FIN
FIN:RET
    P1 ENDP

P2 PROC NEAR

   LEA DX,MESS2
   MOV AH,9
   INT 21H
   ;因为不知道工资到底是多少，最多是十进制5位，最小是十进制1位
   ;所以讨论
   MOV BX,SUM 
   MOV DX,0
   CMP BX,10000
   JB FOUR;低于10000就调到FOUR
   MOV CX,5
   MOV AX,SUM
LP1:DIV SHI;商在AX，余数在DX
    PUSH DX;
    MOV DX,0
    LOOP LP1
    MOV CX,4
LP2:POP DX
    OR DL,30H
    MOV AH,2
    INT 21H
    LOOP LP2
  ;显示小数点
   MOV DL,'.'
   MOV AH,2
   INT 21H

    POP DX
    OR DL,30H
    MOV AH,2
    INT 21H

    JMP FINAL

FOUR:CMP BX,1000
     JB THREE
      
   MOV CX,4
   MOV AX,SUM
LP3:DIV SHI;商在AX，余数在DX
    PUSH DX;
    MOV DX,0
    LOOP LP3
    MOV CX,3
LP4:POP DX
    
    OR DL,30H
    MOV AH,2
    INT 21H
    LOOP LP4
  ;显示小数点
   MOV DL,'.'
   MOV AH,2
   INT 21H

    POP DX
    
    OR DL,30H
    MOV AH,2
    INT 21H

    JMP FINAL

THREE:CMP BX,100
      JB TWO2
       
   MOV CX,3
   MOV AX,SUM
LP5:DIV SHI;
    PUSH DX;   
    MOV DX,0
    LOOP LP5
    MOV CX,2
LP6:POP DX
    
    OR DL,30H
    MOV AH,2
    INT 21H
    LOOP LP6
  ;显示小数点
   MOV DL,'.'
   MOV AH,2
   INT 21H

    POP DX
    
    OR DL,30H
    MOV AH,2
    INT 21H

    JMP FINAL

TWO2:CMP BX,10
     JB ONE1
   
   MOV CX,2
   MOV AX,SUM
LP7:DIV SHI;
    PUSH DX; 
    MOV DX,0
    LOOP LP7
    MOV CX,1
LP8:POP DX
    
    OR DL,30H
    MOV AH,2
    INT 21H
    LOOP LP8
  ;显示小数点
   MOV DL,'.'
   MOV AH,2
   INT 21H

    POP DX
    
    OR DL,30H
    MOV AH,2
    INT 21H

    JMP FINAL

ONE1:MOV DL,'0'
     MOV AH,2
     INT 21H
     MOV DL,'.'
     MOV AH,2
     INT 21H
     MOV DX,SUM
     OR DL,30H
     MOV AH,2
     INT 21H

FINAL:RET
      P2 ENDP

  
CODE ENDS
     END START