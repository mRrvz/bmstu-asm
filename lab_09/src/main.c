#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[], char *arge[])
{
    char buffer[] = "SHELL=/usr/bin/zsh";

    if (!strcmp(*(arge + 26), buffer))
    {
        printf("Access granted");
    }

    return 0; 
}
