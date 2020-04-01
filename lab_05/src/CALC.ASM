PUBLIC to_unsign
PUBLIC to_real_numb
PUBLIC to_reverse_code

EXTRN rev_numb: near
EXTRN real_numb: near
EXTRN unsign_len: byte
EXTRN unsign_str: byte
EXTRN len: byte
EXTRN number: byte

SEGDATA SEGMENT PARA PUBLIC 'DATA'
    bin       db 17 DUP (0)
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE, DS:SEGDATA
to_unsign proc near

    mov si, 4
    mov ax, word ptr [rev_numb]
    xor dx, dx
    mov bx, 10

    lbl:
        div bx
        mov unsign_str[si], dl
        add unsign_str[si], "0"
        xor dx, dx
        inc unsign_len

        dec si
        cmp al, 0

        jne lbl
        
    ret

to_unsign endp

to_real_numb proc near
    ;mov real_numb, 0
    xor cx, cx

    mov cl, len
    dec cx
    mov si, cx

    mov dx, 1

    to_real_lbl:
        xor ax, ax
        mov al, byte ptr[number + si]
        sub ax, "0"
        mul dl
        add word ptr [real_numb], ax

        mov ax, dx
        mov dx, 10
        mul dx
        mov dx, ax

        dec si

        loop to_real_lbl

    ret

to_real_numb endp


to_reverse_code proc near
    mov ax, word ptr[real_numb]
    mov word ptr[rev_numb], ax
    not word ptr[rev_numb]
    inc word ptr[rev_numb]

    ret
to_reverse_code endp

SEGCODE ENDS
END
