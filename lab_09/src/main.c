#include <stdio.h>

int main(int argc, char *argv[], char *arge[])
{
    for (int i = 0; i < argc; i++)
    {
        printf("%s\n", argv[i]);
    }

    //int arr[16];

    /* #pragma omp parallel for
    /for (int i = 0; i < 16; i++)
    {
        *(arr + i) = i;
    }
    */

    return 0;
}

