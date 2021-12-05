/*
** Guillaume Bogard-Coquard - Project
** ReaderELF
** File description:
** Test file for relf_create
*/

#include <criterion/criterion.h>
#include "relf.h"

Test(relf_create, basic_relf_create)
{
    relf_t *relf = relf_create();

    relf_destroy(relf);
}
