PUBLIC change_max_min

EXTRN n: byte
EXTRN m: byte
EXTRN matrix: byte

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    assume CS:SEGCODE
change_max_min proc near
    mov al, byte ptr[n]
    mov bx, 0

    lbl_col:
        mov si, bx
        mov di, bx

        mov dl, byte ptr[matrix + bx]
        mov dh, byte ptr[matrix + bx]
        mov cl, byte ptr[m]

        lbl_row:
            cmp byte ptr[matrix + bx], dl
            jge maxlbl

            go_back1:
            cmp byte ptr[matrix + bx], dh
            jle minlbl

            go_back2:
            add bl, byte ptr[n]

            loop lbl_row

        mov [matrix + si], dl
        mov [matrix + di], dh

        mov cl, al
        dec al

        mov dl, byte ptr[n]
        sub dl, al
        mov bl, dl

        loop lbl_col

    ret

minlbl:
    mov dh, byte ptr[matrix + bx]
    mov si, bx

    jmp go_back2

maxlbl:
    mov dl, byte ptr[matrix + bx]
    mov di, bx

    jmp go_back1

change_max_min endp

SEGCODE ENDS
END
