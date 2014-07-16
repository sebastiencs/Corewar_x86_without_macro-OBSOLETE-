
NAME		= corewar

SRCS		= src/main.asm					\
		  src/arguments.asm				\
		  src/get_dump.asm				\
		  src/save_args.asm				\
		  src/save_champion.asm				\
		  src/list_champions.asm			\
		  src/load_file_in_arena.asm			\
		  src/init_reg.asm				\
		  src/load_arena.asm				\
		  src/init_values_champions.asm			\
		  src/find_max_prog_number.asm			\
		  src/load_champions_in_arena.asm		\
		  src/utils/check_args.asm			\
		  src/utils/usage.asm				\
		  src/utils/attribute_i_to_someone.asm		\
		  src/utils/check_same_prog_number.asm		\
		  src/utils/check_big_prog_number.asm		\
		  src/utils/attribute_prog_number.asm		\
		  src/utils/attribute_one_def.asm		\
		  src/utils/attribute_two_def.asm		\
		  src/utils/is_already_define.asm		\
		  src/utils/attribute_address_defined.asm	\
		  src/utils/attribute_address.asm		\
		  src/utils/swap_int.asm			\
		  src/utils/init_arena.asm			\
		  src/utils/check_place_arena.asm		\
		  src/utils/convert_endian.asm			\
		  src/utils/get_magic.asm			\
		  src/utils/get_size.asm			\
		  src/utils/get_name.asm			\
		  src/utils/get_name_comment_champions.asm	\
		  src/utils/get_comment.asm			\
		  src/utils/my_strcmp.asm			\
		  src/utils/my_strlen.asm			\
		  src/utils/my_strcat.asm			\
		  src/gui/my_gui.asm				\
		  src/gui/get_image_path.asm			\
		  src/gui/load_players_name.asm			\
		  src/gui/put_background.asm			\
		  src/gui/get_list_pc.asm			\
		  src/gui/is_pc.asm				\
		  src/gui/set_color_with_pc.asm			\
		  src/gui/hex_to_str.asm			\
		  src/gui/get_color.asm				\
		  src/gui/print_bytes.asm			\
		  src/gui/get_color_champions.asm

OBJS		= $(SRCS:.asm=.o)

NASM		= nasm

CC		= gcc

INC		= -I includes/

NASMFLAGS	= -f elf $(INC) -g -F dwarf 

CFLAGS		= -Wall -Wextra -L./SDL -lSDL -lSDL_ttf -Xlinker "-rpath=./SDL" -lpthread -lm -ldl -lSDL

RM		= rm -f

all:		$(NAME)

$(NAME):	$(OBJS)
		$(CC) -m32 -o $(NAME) $(OBJS) tmp.o -ggdb $(CFLAGS)
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
