DATA    SEGMENT                 
S1      DB      'ABCDEFGHIJKLMNOPQRSTUVWXYZ'    
COUNT   EQU     $-S1                       
DATA    ENDS
EXTRA   SEGMENT                 
S2      DB      26 DUP(?)           
EXTRA   ENDS
CODE    SEGMENT                 
	ASSUME  CS:CODE,DS:DATA,ES:EXTRA        
START:  MOV     AX,DATA             
	MOV     DS,AX               
	MOV     AX,EXTRA            
	MOV     ES,AX               
	MOV     SI,OFFSET S1            
	MOV     DI,OFFSET S2            
	MOV     CX,COUNT            
NEXT:   MOV     AL,[SI]             
	MOV     ES:[DI],AL          
	INC     SI              
	INC     DI              
	LOOP    NEXT                
	MOV     AH,4CH
	INT     21H             
CODE    ENDS
	END     START               

