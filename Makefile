##
## Guillaume Bogard-Coquard - Project
## ReaderELF
## File description:
## ReaderELF Makefile
##

###################
# Project Section #
###################

########################
# Project output files #
########################

NAME_STATIC_LIB		=	libreaderelf.a

NAME_DYNAMIC_LIB	=	libreaderelf.so

#############################
# Project compilation flags #
#############################

override CFLAGS		+=	-W -Wall -Wextra -Wshadow -Wpedantic -Werror

INCLUDE_PROJECT_DIR	=	./include/

override CPPFLAGS	+=	-I $(INCLUDE_PROJECT_DIR)

override LDFLAGS	+=

override LDLIBS		+=

########################
# Project source files #
########################

SRC_PROJECT_DIR		=	./src/

SRC_PROJECT_FILES	=	$(addprefix $(SRC_PROJECT_DIR), relf_create.c)	\
						$(addprefix $(SRC_PROJECT_DIR), relf_destroy.c)	\
						$(addprefix $(SRC_PROJECT_DIR), relf_open.c)	\
						$(addprefix $(SRC_PROJECT_DIR), relf_show.c)

OBJ_PROJECT_FILES	=	$(SRC_PROJECT_FILES:.c=.o)

#################
# Project rules #
#################

#################

%.o:		%.c
	@$(CC) -c -o $@ $< $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LDLIBS)

#################

all:		static
.PHONY:		all

static:		$(NAME_STATIC_LIB)
.PHONY:		static

$(NAME_STATIC_LIB):		$(OBJ_PROJECT_FILES)
	echo "Building static library ($@)..."
	ar rc $(NAME_STATIC_LIB) $(OBJ_PROJECT_FILES)
.SILENT:	$(NAME_STATIC_LIB)

dynamic:	CFLAGS += -fPIC
dynamic:	LDFLAGS += -shared
dynamic:	$(NAME_DYNAMIC_LIB)
.PHONY:		dynamic

$(NAME_DYNAMIC_LIB):	$(OBJ_PROJECT_FILES)
	echo "Building dynamic library ($@)..."
	$(LD) -o $(NAME_DYNAMIC_LIB) $(OBJ_PROJECT_FILES) $(LDFLAGS) $(LDLIBS)
.SILENT:	$(NAME_DYNAMIC_LIB)

clean:
	echo "Removing project object files..."
	$(RM) $(OBJ_PROJECT_FILES)
	echo "Removing tests object files..."
	$(RM) $(OBJ_TESTS_FILES)
	echo "Removing coverage dump files..."
	for regex in $(COVERAGE_DUMPS_REGEX); do find -name "*$$regex" -type f -delete; done;
	echo "Removing tests executable..."
	$(RM) $(NAME_TESTS)
	for binsubdir in $(BIN_SUBDIRS); do make $@ -C $$binsubdir ; done;
.PHONY:		clean
.SILENT:	clean

fclean:		clean
	echo "Removing libraries output files..."
	$(RM) $(NAME_STATIC_LIB)
	$(RM) $(NAME_DYNAMIC_LIB)
	for binsubdir in $(BIN_SUBDIRS); do make $@ -C $$binsubdir ; done;
.PHONY:		fclean
.SILENT:	fclean
.IGNORE:	fclean

re:			fclean all
.PHONY:		re

############################
# Tests / Coverage Section #
############################

######################
# Tests output files #
######################

COVERAGE_DUMPS_REGEX	=	.gcda	\
							.gcno

NAME_TESTS				=	unit_tests

######################
# Tests binary flags #
######################

TESTS_FLAGS				=	--verbose

######################
# Tests source files #
######################

SRC_TESTS_DIR	=	./tests/

SRC_TESTS_FILES	=	$(addprefix $(SRC_TESTS_DIR), relf_create.c)	\
					$(addprefix $(SRC_TESTS_DIR), relf_open.c)

OBJ_TESTS_FILES	=	$(SRC_TESTS_FILES:.c=.o)

#######################
# Binaries Test files #
#######################

BIN_DIR			=	./bin/

BIN_SUBDIRS		=	$(addprefix $(BIN_DIR), asm/)

##########################
# Tests / Coverage rules #
##########################

tests_run:	CFLAGS += --coverage
tests_run:	LDLIBS += -lcriterion
tests_run:	$(OBJ_TESTS_FILES)
	for binsubdir in $(BIN_SUBDIRS); do make -C $$binsubdir ; done;
	for regex in $(COVERAGE_DUMPS_REGEX); do find -name "*$$regex" -type f -delete; done;
	$(CC) -o $(NAME_TESTS) $(SRC_PROJECT_FILES) $(OBJ_TESTS_FILES) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LDLIBS)
	./$(NAME_TESTS) $(TESTS_FLAGS)
	$(RM) $(NAME_TESTS)
.PHONY:		tests_run
.SILENT:	tests_run

coverage:
	gcovr --exclude tests/
	gcovr --exclude tests/ --branches
.PHONY:		coverage
.SILENT:	coverage
