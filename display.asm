assume cs:codesg,ds:datasg,ss:stacksg
datasg segment
    db 77h,65h,6Ch,63h,6Fh,6Dh,65h,20h,74h,6Fh,20h,6Dh,61h,73h,6Dh,21h
    db 0CAh,0A4h,0F1h
datasg ends
stacksg segment
    db 16 dup (0)
stacksg ends
codesg segment
start:  
    mov ax,datasg
    mov ds,ax
    mov di,0010h
    
    mov ax,stacksg
    mov ss,ax
    mov sp,16

    mov ax,0B800h
    mov es,ax
    mov si,06E0h
    mov cx,3
 s2:push cx
    mov cx,16
    mov bp,40h
    add bp,si
    mov bx,0
 s: mov al,[bx]
    mov es:[bp],al
    inc bp
    mov al,[di]
    mov es:[bp],al
    inc bp
    inc bx
    loop s
    pop cx
    add si,0A0h
    inc di
    loop s2
    
    mov ax,4c00h
    int 21h
codesg ends
end start
