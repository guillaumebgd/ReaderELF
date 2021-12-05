/*
** Guillaume Bogard-Coquard - Project
** ReaderELF
** File description:
** relf_create
*/

#include <stdlib.h>
#include "relf.h"

static void initialize_relf_fields(relf_t *relf)
{
    relf->fd = -1;
    relf->file_length = 0;
    relf->header = NULL;
}

relf_t *relf_create(void)
{
    relf_t *relf = NULL;

    relf = malloc(sizeof(relf_t));
    if (!relf)
        goto end;
    initialize_relf_fields(relf);
    end:
    return relf;
}
