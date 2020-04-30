.model tiny

CODE SEGMENT
    assume cs:code, ds:code
    org 100h

main:
    jmp init
    old_9h dd ?
    is_installed dw 1337

my_9h proc
    push ax
    push bx
    push cx
    push dx

    push es
    push ds
    push cs
    pushf

    pop ds

    call cs:old_9h

    mov ah, 1
    int 16h

    cmp al, 'a'
    jne quit
    
    mov ax, 0B800h
    mov es, ax
    mov di, 300

    mov ah, 02
    int 1AH

    xor cx, cx
    mov ah, 2CH
    int 21h

    xor ax, ax ; часы

    mov al, ch
    mov bl, 10
    div bl

    mov bx, ax

    mov ah, 15
    mov al, bl
    add al, '0'
    stosw

    mov al, bh
    add al, '0'
    stosw

    mov al, ":"
    stosw

    xor ax, ax ; минуты

    mov al, cl
    mov bl, 10
    div bl

    mov bx, ax

    mov ah, 15
    mov al, bl
    add al, '0'
    stosw

    mov al, bh
    add al, '0'
    stosw

    mov al, ":"
    stosw

    xor ax, ax; секунды

    mov al, dh
    mov bl, 10
    div bl

    mov bx, ax

    mov ah, 15
    mov al, bl
    add al, '0'
    stosw

    mov al, bh
    add al, '0'
    stosw

    quit:
        ;popf
        pop ds
        pop es

        pop dx
        pop cx
        pop bx
        pop ax

        iret

my_9h endp

init:
    mov ax, 3509h
    int 21h

    cmp es:is_installed, 1337
    je uninstall

    mov word ptr old_9h, bx
    mov word ptr old_9h + 2, es

    mov ax, 2509h
    mov dx, offset my_9h
    int 21h

    mov dx, offset inst_msg
    mov ah, 9
    int 21h

    mov dx, offset init
    int 27h

uninstall:
    push es
    push ds

    mov dx, word ptr es:old_9h
    mov ds, word ptr es:old_9h + 2
    mov ax, 2509h
    int 21h

    pop ds
    pop es

    mov ah, 49h
    int 21h

    mov dx, offset uninst_msg
    mov ah, 9h
    int 21h

    mov ax, 4C00h
    int 21h

    inst_msg   db 'Timer installed!$'
    uninst_msg db 'Time uninstalled!$'

CODE ends
end main


