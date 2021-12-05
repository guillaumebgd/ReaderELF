/*
** EPITECH PROJECT, 2021
** ReaderELF
** File description:
** ReaderELF main header.
*/

#ifndef RELF_H_
#define RELF_H_

#include <elf.h>

struct relf_s {
    Elf64_Ehdr *header;
};

typedef struct relf_s relf_t;

relf_t *relf_create(void);
void relf_destroy(relf_t *relf);
void relf_open(relf_t *relf, char const *filepath);

#endif /* RELF_H_ */
