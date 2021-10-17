/*
** Guillaume Bogard-Coquard - Project
** ReaderELF
** File description:
** readerelf
*/

#include <criterion/criterion.h>
#include "readerelf.h"

Test(readerelf, sample_test)
{
    readerelf();
    cr_assert(1);
}
