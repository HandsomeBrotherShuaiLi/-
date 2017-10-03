DATA SEGMENT
A DB 40H
B DB 30H
C DB 20H
D DB 10H
S DB ?
Z DB 05H
W DB 02H
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:MOV AX ,DATA
      MOV DS, AX
      MOV AL, A
      IMUL B  ;乘积存在AX
      MOV CL, D
      ADD CL, C;c+d
      IDIV CL;(A*B)/(C+D) 商在AL，余数在AH
      MOV CL,AL;CL中存第一步的结果
      MOV AL,A
      MOV AH,B
      SUB AL,AH
      IMUL Z
      IDIV W;商在AL，余数在AH
      ADD CL,AL
      MOV AL,C
      MOV AH,0
      IDIV D
      ADD CL,AL
      MOV S,CL
      MOV AX, 4C00H
      INT 21H
 CODE ENDS
      END START
      
    
      
