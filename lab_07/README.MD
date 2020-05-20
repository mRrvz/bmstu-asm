# Usage

```
    nasm -f elf64 -o copy.o copy.asm
    gcc -S -masm=intel -o main.o main.c
    gcc main.o copy.o
```
