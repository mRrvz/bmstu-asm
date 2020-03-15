PUBLIC change_max_min

EXTRN n: byte
EXTRN m: byte
EXTRN matrix: byte

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    assume CS:SEGCODE
change_max_min proc near
    mov bl, byte ptr[m]
    mov al, 0

    lbl_row:
        mov si, ax
        mov di, ax

        mov dl, byte ptr[matrix + ax]
        mov dh, byte ptr[matrix + ax]
        mov cl, byte ptr[n]

        lbl_col:
            cmp dl, byte ptr[matrix + ax]
            jge maxlbl
            cmp dh, byte ptr[matrix + ax]
            jle minlbl
            add al, n

            loop lbl_col

        mov [matrix + si], dh
        mov [matrix + di], dl

        mov dl, 9
        sub dl, al
        mov al, dl

        mov cl, bl
        sub bl, 1

        loop lbl_row

    ret
change_max_min endp

minlbl:
    mov dl, byte ptr[matrix]
    mov si, ax

    ret

maxlbl:
    mov dh, byte ptr[matrix]
    mov di, ax

    ret

SEGCODE ENDS
END
