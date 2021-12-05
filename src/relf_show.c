/*
** Guillaume Bogard-Coquard - Project
** ReaderELF
** File description:
** relf_show
*/

#include <stdio.h>
#include "relf.h"

void relf_show(relf_t const *relf)
{
    printf("fd -> %d\n", relf->fd);
    printf("file_length -> %zu\n", relf->file_length);
    printf("architecture -> %d\n", relf->architecture);
    printf("header -> %p\n", (void *)relf->header);
}
