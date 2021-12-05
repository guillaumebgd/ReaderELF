/*
** EPITECH PROJECT, 2021
** ReaderELF
** File description:
** ReaderELF main header.
*/

#ifndef RELF_H_
#define RELF_H_

#include <stddef.h>
#include <elf.h>

typedef enum relf_arch_s {
    RELF_ARCH_NONE = ELFCLASSNONE,
    RELF_ARCH_x32 = ELFCLASS32,
    RELF_ARCH_x64 = ELFCLASS64
} relf_arch_t;

typedef struct relf_s {
    int fd;
    size_t file_length;
    relf_arch_t architecture;
    Elf64_Ehdr *header;
} relf_t;

relf_t *relf_create(void);
void relf_destroy(relf_t *relf);
int relf_open(relf_t *relf, char const *filepath);
void relf_show(relf_t const *relf);

#endif /* RELF_H_ */
