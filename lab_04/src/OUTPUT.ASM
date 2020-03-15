PUBLIC newline
PUBLIC prnt_matrix

EXTRN n: byte
EXTRN m: byte
EXTRN matrix: byte

SEGDATA SEGMENT PARA COMMON 'DATA'
SEGDATA ENDS


SEGCODE SEGMENT PARA PUBLIC 'CODE'
    assume CS:SEGCODE, DS:SEGDATA
newline proc near
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h

    ret
newline endp

prnt_matrix proc near
    mov ah, 2
    mov bl, byte ptr[m]
    mov si, 0
    
    prnt_col:
        mov cl, byte ptr[n]
        prnt_row:
            mov dl, byte ptr[matrix + si]
            inc si
            int 21h

            mov dl, " "
            int 21h
            loop prnt_row

        call newline

        mov cl, bl
        sub bl, 1
        mov ah, 2
        loop prnt_col

    ret

prnt_matrix endp

SEGCODE ENDS
END
