#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION

#include <stdio.h>
#include <string.h>

#include "lib/stb_image.h"
#include "lib/stb_image_write.h"


#define N 100000
#define true 1
#define __JPG 3
#define __PNG 4

int main(void)
{
    setbuf(stdout, NULL);

    int width, height, n;
    unsigned char *image = stbi_load("1.jpg", &width, &height, &n, __JPG);
    unsigned char *original = stbi_load("1.jpg", &width, &height, &n, __JPG);

    int32_t x = 0;
    printf("%d %d %d\n", width, height, n);
    char img_name[300];
    printf("%zu", sizeof(*(image + 0)));

    for (int j = 0; j < 128; j++)
    {
        image = original;

        for (int i = 0; i < (width * height * n + 1) / 64 - 64; i++)
        {
            //int *x = malloc(sizeof(char) * 64);
            //if (x == NULL)

            __asm__ (
                ".intel_syntax noprefix\n\t"
                "movq mm0, %0\n\t"
                : "=r" (image)
                : "r" (height)
                : "ecx", "eax"
            );

            //*(image + i) = *(image + i) = j % (*(original + i) + 1);
            //stbi_image_free(image);
            //printf("%d ", *(image + i));
            image += 64;
            //printf("%d %d\n", i, j);
        }

        sprintf(img_name, "jpgs/%d.jpg", j);
        //stbi_write_jpg(img_name, width, height, n, image, 100);
    }

    //stbi_write_jpg("4.jpg", width, height, n, image, 100);
    //stbi_image_free(image);
    //stbi_image_free(original);

    return 0;
}
