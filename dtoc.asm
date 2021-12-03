assume cs:code,ss:stack
data segment
    db 10 dup (0)
data ends
stack segment
    db 16 dup (0)
stack ends
code segment
 start: mov ax,stack
        mov ss,ax
        mov sp,16
        mov ax,12666
        mov bx,data
        mov ds,bx
        mov si,0
        call dtoc

        mov dh,8
        mov dl,10h
        mov cl,2
        call show_str
 dtoc:  push ax
        push si
        push dx
        push cx
        mov di,0
   t:   mov cx,ax 
        jcxz re
        mov dx,0
        mov bx,0Ah
        div bx
        add dx,30h
        push dx
        inc di
        jmp short t
    re: mov cx,di
  ver:  pop [si]
        inc si
        loop ver

        pop cx
        pop dx
        pop si
        pop ax
        ret
 show_str:push dx
        push cx
        push es
        push bx
        push ax

        mov ax,0B800h
        mov es,ax
        mov ax,0
        mov al,0A0h                   ;地址换算
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