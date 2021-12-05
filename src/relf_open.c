/*
** Guillaume Bogard-Coquard - Project
** ReaderELF
** File description:
** relf_open
*/

#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>
#include <string.h>
#include "relf.h"

int relf_open(relf_t *relf, char const *filepath)
{
    relf->fd = open(filepath, O_RDONLY);
    if (relf->fd < 0) {
        return -1;
    }

    // Think about using fstat().
    const off_t file_length = lseek(relf->fd, 0, SEEK_END);

    relf->file_length = file_length;
    relf->header = mmap(NULL, relf->file_length, PROT_READ, MAP_SHARED, relf->fd, 0);

    if (strncmp((const char *)relf->header->e_ident, ELFMAG, strlen(ELFMAG)) != 0) {
        return -1;
    }

    switch (relf->header->e_ident[EI_CLASS]) {
        case RELF_ARCH_x32:
            relf->architecture = RELF_ARCH_x32;
            break;
        case RELF_ARCH_x64:
            relf->architecture = RELF_ARCH_x64;
            break;
        case RELF_ARCH_NONE:
        default:
            return -1;
    }
    return 0;
}
