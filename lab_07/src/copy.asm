global copy
section .text
copy:
    mov rcx, rdi
    lea rsi, [rsi]
    lea rdi, [rdx]
    rep movsb
    ret
