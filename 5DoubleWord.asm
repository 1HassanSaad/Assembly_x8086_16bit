; multi-segment executable file template.

data segment
    ; add your data here!
    data1  dd EE6B2800H,B2D05E00H,77359400H,3B9ACA00H,EE6B2800H
    result db 5 dup(?)
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    
    
    mov cx,04H
    mov si,offset data1
    mov ax,word ptr [si]
    add si,2
    mov bx,word ptr [si] 
    add si,2
    clc
    
A:  adc ax,word ptr [si]
    inc si
    inc si
    adc bx,word ptr [si]
    inc si
    inc si
    adc dl,00
    loop A
    mov word ptr result,ax
    mov word ptr result+2,bx
    mov byte ptr result+4,dl
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
