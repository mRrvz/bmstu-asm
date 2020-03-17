EXTRN newline: near
EXTRN prnt_matrix: near
EXTRN change_max_min: near
EXTRN space: near

PUBLIC m
PUBLIC n
PUBLIC matrix

STK SEGMENT PARA STACK 'STACK'
    db 200 dup (0)
STK ENDS

SEGDATA SEGMENT PARA COMMON 'DATA'
    m             db 1; строки
    n             db 1; столбцы

    matrix        db 81 DUP ("0")
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    assume CS:SEGCODE, DS:SEGDATA, SS:STK
main:
    mov ax, SEGDATA
    mov ds, ax

    mov ah, 1
    int 21h
    mov m, al
    sub m, "0"

    call space

    mov ah, 1
    int 21h
    mov n, al
    sub n, "0"

    call newline

    mov al, m
    mul n
    mov cx, ax

    mov si, 0
    read_lbl:
        mov ah, 1
        int 21h
        mov matrix[si], al
        inc si

        call space

        mov ax, si
        mov dh, byte ptr[n]
        div dh

        cmp ah, 0
        je call_newline

        go_back:
        loop read_lbl

    call newline
    call change_max_min
    call prnt_matrix

    mov ax, 4c00h
    int 21h

call_newline:
    call newline
    jmp go_back

SEGCODE ENDS
END main
