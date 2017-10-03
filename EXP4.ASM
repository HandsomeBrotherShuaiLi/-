_DATA   SEGMENT 'DATA'
Msg 	DB  13, 10, "Please input a number: ", 13, 10, "$"
s1  	DB  9, "four", 13, 10, '$'
s2  	DB  9, "five", 13, 10, '$'
s3  	DB  9, "six", 13, 10, '$'
err 	DB  9, "error!", 13, 10, '$'
_DATA   ENDS
_TEXT   SEGMENT 'CODE'
	ASSUME CS: _TEXT, DS: _DATA
Start:  MOV AX, _DATA
	MOV DS, AX
Again:  MOV AH, 9
	MOV DX, Offset Msg
	INT 21h
	MOV AH, 1
	INT 21h
	SUB AL, '4'
	JL  Error   ; 输入字符小于'4'的情况
	CMP AL, 3
	JLE Loc1
Error:  MOV AL, 4
Loc1:   MOV AH, 0
	ADD AX, AX  ;AX×2TAX
	MOV BX, AX
	JMP Word Ptr CS: CaseTab [BX]
CaseTab DW  Case1, Case2, Case3, Case4, Default
Default:MOV DX, Offset err
	JMP EndSwitch
Case1:  MOV DX, Offset s1
	JMP EndSwitch
Case2:  MOV DX, Offset s2
	JMP EndSwitch
Case3:  MOV DX, Offset s3
	JMP EndSwitch
Case4:  MOV AX, 4C00h
	INT 21h
EndSwitch:  MOV AH, 9
	INT 21h
	JMP Again
_TEXT   ENDS
	END Start
