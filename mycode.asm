; multi-segment executable file template.

data segment
    data1 dd -1000000000d
    data2 dd 2000000000d            ;2,000,000,000 + 2,000,000,000 = 4,000,000,000 Decimal
    result dd 2 dup(?)
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    mov si,offset data1
    mov di,offset data2
    mov ax,word ptr [si]
    add ax,word ptr [di]
    jo o
    jno no 

o:  mov bx,ax
    inc si
    inc si
    inc di
    inc di
    mov ax,word ptr [si]
    cwd
    add ax,word ptr [di]
    inc ax
    jmp end
no: mov bx,ax
    inc si
    inc si
    inc di
    inc di
    mov ax,word ptr [si]
    cwd
    add ax,word ptr [di]   
end:mov si,offset result
    mov [si],bx
    inc si 
    inc si
    mov [si],ax
    inc si
    inc si
    mov [si],dx
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
