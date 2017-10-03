; multi-segment executable file template.

data segment
    A DB 92H; add your data here!
    B DB 7AH
    C DB 00H
ends

code segment   
    assume CS:code,DS:data
start:

    mov ax, data
    mov ds, ax
    mov  al,A
    add  al,B
    mov C,al
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
