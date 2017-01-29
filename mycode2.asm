; multi-segment executable file template.

data segment
    data1 dw +20000d,+20000d,+20000d,-20000d,+20000d,-20000d,+20000d,-20000d,+20000d
    result dw 2 dup(?)
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

    mov cx,09H
    mov si,offset data1
    mov bx,0000h
    mov di,0000h
     
for:mov ax,[si]
    cwd
    add bx,ax
    add di,dx
    inc si
    inc si
    loop for    
    ;mov si,offset result
    ;mov [si],bx
    ;inc si
    ;inc si
    ;mov [si],di
    
    mov cx,0009H
    mov ax,bx
    ;mov dx,di
    idiv cx 
    mov result,ax    

    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
