#include <stdio.h>
#include <string.h>

#define N 100

int main(void)
{
    setbuf(stdout, NULL);

    char string[] = "test string";
    int len = 0;

    __asm__ (
        ".intel_syntax noprefix\n\t"
        "mov ecx, 32000\n\t"
        "mov al, 0\n\t"
        "lea rdi, [%1]\n\t"
        "repne scasb\n\t"
        "mov eax, 32000\n\t"
        "sub eax, ecx\n\t"
        "dec eax\n\t"
        "mov %0, eax\n\t"
        : "=r" (len)
        : "r" (string)
        : "ecx", "eax", "al", "rdi"
    );

    printf("ASM length: %d\nC length: %d\n", len, strlen(string));

    char string_copy[N];

    /* Внутри copy нужно сделать так, чтобы если адреса накладываются, не было кринжа
       но я сдал и исправлять не буду :) */

    copy(len, string, string_copy);
    printf("ORIGINAL: %s\nCOPY: %s", string_copy, string);

    return 0;
}
