DATA	SEGMENT
X	DW  	55, 112, 37, 82
Y	DW  	4 DUP (?)
DATA	ENDS
CODE	SEGMENT
	ASSUME	CS: CODE, DS: DATA
START:	MOV 	AX, DATA
	MOV	DS, AX
	MOV	DI, 2		;��2��Ԫ���������ڵ�λ��
	MOV	AX, X[DI]	;ȡ��X�����2��Ԫ��
	MOV	Y[DI], AX	;����Y�����2��Ԫ����
	MOV	AX, X[DI+4]	;ȡ��X������ĸ�Ԫ��
	MOV	Y[DI+4], AX	;����Y������ĸ�Ԫ����
        MOV     X[2],0
        MOV     X[3],0
        MOV     X[6],0
        MOV     X[7],0
	MOV	AX, 4C00H
	INT  	21H
CODE	ENDS
	END	START
