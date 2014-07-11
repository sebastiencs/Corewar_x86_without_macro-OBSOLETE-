
NAME		= corewar

SRCS		= src/main.asm			\
		  src/arguments.asm		\
		  src/get_dump.asm		\
		  src/utils/check_args.asm	\
		  src/utils/usage.asm		\
		  src/utils/my_strcmp.asm

OBJS		= $(SRCS:.asm=.o)

NASM		= nasm

CC		= gcc

INC		= -I includes/

NASMFLAGS	= -f elf $(INC) -g -F dwarf 

RM		= rm -f

all:		$(NAME)

$(NAME):	$(OBJS)
		$(CC) -m32 -o $(NAME) $(OBJS) -ggdb
		@echo -e "\033[0;032m[$(NAME)] Compiled\033[0;0m"

%.o:		%.asm
		$(NASM) $(NASMFLAGS) -o $@ $<

clean:
		@echo -e "\033[0;031m[clean] " | tr -d '\n'
		$(RM) $(OBJS)
		@echo -e "\033[0;0m" | tr -d '\n'

fclean:		clean
		@echo -e "\033[0;031m[fclean] " | tr -d '\n'
		$(RM) $(NAME)
		@echo -e "\033[0;0m" | tr -d '\n'

re:		fclean all
