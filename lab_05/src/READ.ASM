PUBLIC read_numb

PUBLIC number
PUBLIC len

PUBLIC unsign_len
PUBLIC unsign_str

PUBLIC real_numb
PUBLIC rev_numb

EXTRN newline: near
EXTRN to_real_numb: near
EXTRN to_unsign: near
EXTRN to_reverse_code: near

SEGDATA SEGMENT PARA PUBLIC 'DATA'
    max_size   db 7
    len        db 0
    number     db 7 DUP ("$")

    unsign_len db 0
    unsign_str db 6 DUP ("$")

    real_numb  dw 0
    rev_numb   dw 0

    ent_msg  db "Enter number (with sign): $"
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE, DS:SEGDATA
read_numb proc near
    call fill_nulls
    call newline

    mov ah, 9
    mov dx, offset ent_msg
    int 21h

    mov ah, 0AH
    mov dx, offset max_size
    int 21h

    call to_real_numb
    call to_reverse_code
    call to_unsign
    call newline
    
    ret

read_numb endp

fill_nulls proc near
    mov len, 0
    mov unsign_len, 0
    mov word ptr[real_numb], 0
    mov word ptr[rev_numb], 0

    mov al, "$"
    lea di, number
    mov cx, 7
    stosb

    lea di, unsign_str
    mov cx, 6
    stosb

    ret

fill_nulls endp

SEGCODE ENDS
END
