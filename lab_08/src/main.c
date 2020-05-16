#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION

#include <stdio.h>

#include "stb/stb_image.h"
#include "stb/stb_image_write.h"

#define QWORD 8
#define MAX_QLTY 100

#define _JPG 3
#define _PNG 4

#define OK 0
#define PIXEL_STEP 8
#define MAX_BUFF_SIZE 30
#define SAVE_PATH "temp_pht/%d.jpg"

int main(int argc, char *argv[])
{
    setbuf(stdout, NULL);

    int width, height, n;
    unsigned char *image = stbi_load(argv[1], &width, &height, &n, _JPG);
    unsigned char *bytes_head = image;

    char img_name[MAX_BUFF_SIZE];
    unsigned char *qword_ptr = malloc(QWORD);
    memset(qword_ptr, PIXEL_STEP, QWORD);

    for (int j = 0; j < 256 / PIXEL_STEP; j++)
    {
        image = bytes_head;

        for (int i = 0; i < width * height * n / QWORD; i++)
        {
            __asm__ (
                ".intel_syntax noprefix\n\t"
                "movq mm0, [%1]\n\t"
                "movq mm1, [%2]\n\t"
                "paddusb mm0, mm1\n\t"
                "movq [%1], mm0\n\t"
                : "=r" (image)
                : "r" (image), "r" (qword_ptr)
                : "mm0", "mm1"
            );

            image += QWORD;
        }

        fprintf(stdout, "%d picture finished\n", j + 1);

        image = bytes_head;
        snprintf(img_name, MAX_BUFF_SIZE - 1, SAVE_PATH, j);
        stbi_write_jpg(img_name, width, height, n, image, MAX_QLTY);
    }

    stbi_image_free(image);
    free(qword_ptr);

    fprintf(stdout, "Image processing completed, making gif...\n");
    system("convert -delay 6 -loop 0 $(ls temp_pht -1 | sort -n | awk '{print \"temp_pht/\"$1}') gif.gif");

    return OK;
}
