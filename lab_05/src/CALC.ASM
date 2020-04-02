PUBLIC to_unsign
PUBLIC to_real_numb
PUBLIC to_reverse_code
PUBLIC to_bin

EXTRN rev_numb: near
EXTRN real_numb: near
EXTRN unsign_len: byte
EXTRN unsign_str: byte
EXTRN len: byte
EXTRN number: byte
EXTRN bin_len: byte
EXTRN bin_str: byte
EXTRN hex_len: byte
EXTRN hex_str: byte

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE
to_unsign proc near

    mov si, 5
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
    xor cx, cx

    mov cl, len
    dec cx
    mov si, cx

    mov bx, 1

    to_real_lbl:
        xor ax, ax
        mov al, byte ptr[number + si]
        sub ax, "0"
        mul bx
        add word ptr [real_numb], ax

        mov ax, bx
        mov bx, 10
        mul bx
        mov bx, ax

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
    

to_bin proc near
    cmp byte ptr[number], "-"
    je rev_to_ax
    mov ax, word ptr[real_numb]

    back:
    mov si, 15
    xor dx, dx
    mov bx, 2

    lbl:
        div bx
        mov bin_str[si], dl
        add bin_str[si], "0"
        xor dx, dx
        inc bin_len

        dec si
        cmp ax, 0
        jne lbl

    ret

    rev_to_ax:
        mov ax, word ptr[rev_numb]
        jmp back

to_bin endp


to_hex proc near
    xor cx, cx

    mov bx, 16
    mov si, 5
    mov ax, word ptr[real_numb]
    xor dx, dx

    to_hex_lbl:
        div bx
        mov hex_str[si], dl

        cmp dl, 9 
        jg hex_char
        add hex_str[si], "0"

        back:
        xor dx, dx
        inc hex_len

        dec si
        cmp ax, 0
        jne to_hex_lbl


    xor bx,bx
    mov bl, 5
    sub bl, hex_len
    mov dh, byte ptr[number]
    mov hex_str[bx], dh

    ret

    hex_char:
        add hex_str[si], 55
        jmp back

to_hex endp

SEGCODE ENDS
END
