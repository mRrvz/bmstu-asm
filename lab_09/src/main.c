#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[], char *arge[])
{
    char buffer[] = "SHELL=/bin/zsh";

    if (!strcmp(*(arge + 27), buffer))
    {
        printf("Access granted");
    }

    return 0;
}

