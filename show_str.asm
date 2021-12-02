assume cs:code,ss:stack
data segment
    db 'Welcome to masm!',0
data ends
stack segment
    dd 8 dup (0)
stack ends
code segment
start:  mov ax,stack
        mov ss,ax
        mov sp,30
        mov dh,8
        mov dl,10h
        mov cl,2
        mov ax,data
        mov ds,ax
        mov si,0
        call show_str

        mov ax,4c00h
        int 21h
show_str:push dx
        push cx
        push es
        push bx
        push ax

        mov ax,0B800h
        mov es,ax
        mov ax,0
        mov al,0A0h                 ;地址换算
        dec dh
        mul dh
        mov dh,0
        add ax,dx
        mov bx,ax                     ;存储偏移地址es:[bx]
        mov ax,0
        mov al,cl                     ;存储字体格式到al
    s:  mov cl,ds:[si]
        mov ah,cl
        mov ch,0
        jcxz ok
        mov es:[bx],ah
        inc bx
        mov es:[bx],al
        inc bx
        inc si
        jmp short s
    ok: pop ax
        pop bx
        pop es
        pop cx
        pop dx
        ret    
code ends
end start