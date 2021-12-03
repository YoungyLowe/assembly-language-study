assume cs:code,ss:stack
data segment
    dw 8 dup (0)
data ends
stack segment
    dw 8 dup (0)
stack ends
code segment
start:  mov ax,data
        mov ds,ax
        mov ax,stack
        mov ss,ax
        mov sp,16

        mov ax,4240h
        mov dx,000Fh
        mov cx,5
        call divdw
    
        mov ax,4c00h
        int 21h
 divdw: mov si,0
        push ax
        mov ax,dx
        mov dx,0
        div cx
        mov bx,ax           ;bx保存H/N的商,dx保存H/N的余数
        pop ax
        div cx
        mov cx,dx           ;cx保存X/N的余数,ax保存商，商为结果的低16位
        mov dx,bx           ;dx保存结果的高16位
        ret
code ends
end start
