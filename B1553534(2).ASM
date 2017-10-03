DATA SEGMENT
A DB 40H
B DB 30H
C DB 20H
D DB 10H
S DW ?
Z DW 0005H
W DW 0002H
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:MOV AX ,DATA
      MOV DS, AX
      MOV AL, A
      IMUL B  ;乘积存在AX
      CWD; (DX AX)得到a*b
      MOV CX,AX;ax->cx
      MOV AL,C
      CBW;c扩展
      MOV BX,AX;BX存c扩展
      MOV AL,D
      CBW
      ADD BL,AL
      ADC BH,AH;c+d 16位
      MOV AX,CX
      IDIV BX;(A*B)/(C+D) 商在AX，余数在DX
      MOV CX,AX;第一步结果16位存在CX
      MOV AL,A
      CBW 
      MOV BX,AX
      MOV AL,B
      CBW
      SUB BL,AL
      SBB BH,AH;A-B 存在BX里
      MOV AX,Z
      IMUL BX;5*(A-B）->(DX,AX)
      IDIV W;5*(A-B)/2->商在AX，余数在DX
      CWD;  符号扩展32位（DX,AX)
      MOV BX,AX;第二部低位结果存在BX
      MOV AX,CX
      MOV CX,DX;第二步结果是（CX,BX)
      CWD;第一步结果是（DX,AX)
      ADD BX,AX
      ADC CX,DX;(前两部结果是（CX,BX))
      MOV AL,C
      CBW
      IDIV D
      CBW
      CWD
      ADD AX,BX
      ADC DX,CX
      MOV S,AX
      MOV AX, 4C00H
      INT 21H
 CODE ENDS
      END START
