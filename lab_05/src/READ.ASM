PUBLIC read_numb
PUBLIC number
PUBLIC len
PUBLIC unsign_len
PUBLIC unsign_str
PUBLIC real_numb
PUBLIC rev_numb
PUBLIC bin_len
PUBLIC bin_str
PUBLIC hex_len
PUBLIC hex_str

EXTRN newline: near
EXTRN to_real_numb: near
EXTRN to_unsign: near
EXTRN to_reverse_code: near
EXTRN to_bin: near
EXTRN to_hex: near

SEGDATA SEGMENT PARA PUBLIC 'DATA'
    max_size   db 8
    len        db 0
    number     db 8 DUP ("$")

    unsign_len db 0
    unsign_str db 7 DUP ("$")

    bin_len    db 0
    bin_str    db 16 DUP ("0")
               db "$" 
    
    hex_len    db 0
    hex_str    db 6 DUP ("$")
               db "$"

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
    call to_bin
    call to_hex
    call newline
    
    ret

read_numb endp


fill_nulls proc near
    mov len, 0
    mov unsign_len, 0
    mov bin_len, 0
    mov hex_len, 0
    mov word ptr[real_numb], 0
    mov word ptr[rev_numb], 0

    mov ax, seg number
    mov es, ax
    mov di, offset number
    mov al, "$"
    mov cx, 8
    rep stosb

    mov ax, seg unsign_str
    mov es, ax
    mov di, offset unsign_str
    mov al, "$"
    mov cx, 7
    rep stosb

    mov ax, seg bin_str
    mov es, ax
    mov di, offset bin_str
    mov al, "0"
    mov cx, 16
    rep stosb

    mov ax, seg hex_str
    mov es, ax
    mov di, offset hex_str
    mov al, "$"
    mov cx, 6
    rep stosb

    ret

fill_nulls endp

SEGCODE ENDS
END
