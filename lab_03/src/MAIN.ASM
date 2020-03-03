EXTRN newline: near
EXTRN output: near

PUBLIC string
PUBLIC print_cnt

SEGDATA SEGMENT PARA COMMON 'DATA'
    max_size      db 100
    string_len    db 0
    string        db 100 DUP ("$")

    max_size2     db 3
    print_cnt_len db 0
    print_cnt     db 3 DUP ("$")
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    assume CS:SEGCODE, DS:SEGDATA
main:
    mov ax, SEGDATA
    mov ds, ax

    mov ah, 0Ah
    mov dx, offset max_size
    int 21h

    call newline

    mov ah, 0Ah
    mov dx, offset max_size2
    int 21h

    call newline
    call output

    mov ax, 4c00h
    int 21h
SEGCODE ENDS
END main
