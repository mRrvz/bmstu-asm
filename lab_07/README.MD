# Usage

```
    nasm -f elf64 -o copy.o copy.asm
    gcc -S -masm=intel -o main.s main.c
    gcc main.s copy.o
```
