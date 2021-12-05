/*
** Guillaume Bogard-Coquard - Project
** ReaderELF
** File description:
** relf_destroy
*/

#include <stdlib.h>
#include "relf.h"

void relf_destroy(relf_t *relf)
{
    free(relf);
}
