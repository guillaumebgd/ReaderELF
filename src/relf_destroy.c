/*
** Guillaume Bogard-Coquard - Project
** ReaderELF
** File description:
** relf_destroy
*/

#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include "relf.h"

void relf_destroy(relf_t *relf)
{
    if (relf->fd >= 0)
        close(relf->fd);
    munmap(relf->header, relf->file_length);
    free(relf);
}
