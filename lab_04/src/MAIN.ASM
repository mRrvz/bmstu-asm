EXTRN newline: near
EXTRN prnt_matrix: near
EXTRN change_max_min: near

PUBLIC m
PUBLIC n
PUBLIC matrix

STK SEGMENT PARA STACK 'STACK'
    db 200 dup (0)
STK ENDS

SEGDATA SEGMENT PARA COMMON 'DATA'
    m             db 1
    n             db 1

    matrix        db 81 DUP ("0")
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    assume CS:SEGCODE, DS:SEGDATA, SS:STK
main:
    mov ax, SEGDATA
    mov ds, ax

    mov ah, 01h
    int 21h
    mov m, al
    sub m, "0"

    int 21h
    mov n, al
    sub n, "0"

    call newline

    mov al, m
    mul n
    mov cx, ax

    mov ah, 01h
    mov bx, 0
    read_lbl:
        int 21h
        mov matrix[bx], al
        add bl, 1
        loop read_lbl

    call newline
    call prnt_matrix

    call newline
    call change_max_min
    call prnt_matrix

    mov ax, 4c00h
    int 21h
SEGCODE ENDS
END main
