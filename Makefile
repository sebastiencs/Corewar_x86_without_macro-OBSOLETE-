
NAME		= corewar

SRCS		= src/main.asm		\
		  src/arguments.asm

OBJS		= $(SRCS:.asm=.o)

NASM		= nasm

CC		= gcc

INC		= -I includes/

NASMFLAGS	= -f elf $(INC)

RM		= rm -f

all:		$(NAME)

$(NAME):	$(OBJS)
		$(CC) -m32 -o $(NAME) $(OBJS)

%.o: %.asm
		$(NASM) $(NASMFLAGS) -o $@ $<

clean:
		$(RM) $(OBJS)

fclean:	clean
		$(RM) $(NAME)

re:		fclean all
