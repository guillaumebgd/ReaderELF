##
## Guillaume Bogard-Coquard - Project
## ReaderELF
## File description:
## ReaderELF ASM Binaries Makefile
##

SRC_x64	=	_strcase_cmp.asm

OBJ_x64	=	$(SRC_x64:.asm=.o)

# Trick used to get SRC_x64 files without the extension
BIN_x64	=	$(SRC_x64:.asm=)

#####################

override ASFLAGS	+=	

#####################
# Compiler & Linker #
#####################

ASMC	=	nasm

LD		=	ld

#####################

%.o:	%.asm
	$(ASMC) -o $@ $< $(ASFLAGS)

all::	x32
all::	x64
.PHONY:	all

x32:	ASFLAGS += -f elf32
x32:	$(OBJ_x32)
	for file in $(BIN_x32); do $(LD) -m elf_i386 $$file.o -o $$file; done;
.PHONY:	x32

x64:	ASFLAGS += -f elf64
x64:	$(OBJ_x64)
	for file in $(BIN_x64); do $(LD) $$file.o -o $$file; done;
.PHONY:	x64

clean:
	$(RM) $(OBJ_x32)
	$(RM) $(OBJ_x64)
.PHONY:	clean

fclean: clean
	$(RM) $(BIN_x32)
	$(RM) $(BIN_x64)
.PHONY:	fclean

re::	fclean
re::	all
.PHONY:	re
