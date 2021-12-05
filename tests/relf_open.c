/*
** Guillaume Bogard-Coquard - Project
** ReaderELF
** File description:
** Test file for relf_create
*/

#include <criterion/criterion.h>
#include "relf.h"

Test(relf_open, basic_relf_open)
{
    char const *filepath = "./bin/asm/_strcase_cmp";
    relf_t *relf = relf_create();

    cr_assert(relf_open(relf, filepath) == 0);
    relf_show(relf);
    relf_destroy(relf);
}
