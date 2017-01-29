; multi-segment executable file template.

data segment
    ; add your data here! 
    ;100,000,000,000||||500,000,000,000||||800,000,000,000||||300,000,000,000||||1,000,000,000,000
    data1  dd 4876E800H,00000017H,6A528800H,00000074H,43B74000H,000000BAH,D964B800H,00000045H,D4A51000H,000000E8H
    result db 10 dup(?)
    count  dw ?
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
    mov dx,word ptr [si] 
    add si,2
    mov di,word ptr [si] 
    add si,2
    clc
    
A:  adc ax,word ptr [si]
    inc si
    inc si
    adc bx,word ptr [si]
    inc si
    inc si
    adc dx,word ptr [si]
    inc si
    inc si
    adc di,word ptr [si]
    inc si
    inc si
    mov count,cx
    adc cx,00
    mov cx,word ptr result+8
    mov cx,count
    loop A
    
    mov word ptr result,ax
    mov word ptr result+2,bx
    mov word ptr result+4,dx
    mov word ptr result+6,di
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
