EXTRN print_sign: near
EXTRN print_unsign: near
EXTRN read_numb: near
EXTRN newline: near

STK SEGMENT PARA STACK 'STACK'
    db 200 dup (?)
STK ENDS

SEGDATA SEGMENT PARA PUBLIC 'DATA'
    menu_prnt db "1. Enter number"
              db 10
              db 13
              db "2. Print signed number"
              db 10
              db 13
              db "3. Print unsigned number" 
              db 10
              db 13
              db "4. Convert to unsigned binary and print it"
              db 10
              db 13
              db "5. Convert to signed hexadecimal and print it"
              db 10
              db 13
              db "6. Exit" 
              db 10
              db 13
              db "Enter action: $"

    f_ptr     dw 6 DUP (0)
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE, DS:SEGDATA, SS:STK
main:
    mov ax, SEGDATA
    mov ds, ax

    mov f_ptr[0], read_numb
    mov f_ptr[2], print_sign
    mov f_ptr[4], print_unsign
    ;mov f_ptr[6], to_bin_unsign
    ;mov f_ptr[8], to_hex_sign
    mov f_ptr[10], exit

    menu:
        mov ah, 9
        mov dx, 0
        int 21h

        mov ah, 1
        int 21h

        mov ah, 0
        sub al, "1"
        mov dl, 2
        mul dl
        mov bx, ax

        call newline
        call f_ptr[bx]
        call newline
    jmp menu

exit proc near
    mov ax, 4c00h
    int 21h
exit endp

SEGCODE ENDS
END MAIN
