#include <stdio.h>

typedef struct          s_champions
{
  char                  *filename;
  int                   size;
  unsigned int          prog_number;
  unsigned int          load_address;
  char                  *name;
  char                  *comment;
  int                   *reg;
  int                   pc;
  unsigned int          carry;
  unsigned int          last_live;
  int                   cycle_to_wait;
  int                   color_gui;
  struct s_champions    *next;
}                       t_champions;

typedef struct          s_corewar
{
  unsigned char         *arena;
  unsigned char         *info_arena;
  unsigned int          nb_champions;
  t_champions           *champions;
  t_champions           *last_champions;
  int                   last_live_nb;
  char                  *last_live_name;
  int                   prog_number_max;
  unsigned long long    nbr_cycle_dump;
  int                   nbr_live_cur;
  int                   is_desassembler;
  int                   cycle_to_die_cur;
}                       t_corewar;

int		printa(t_corewar *core)
{
  t_champions	*tmp;

  tmp = core->champions;
  while (tmp)
  {
    printf("filename = %s addr = %d prog_number = %d size = %d name = '%s' comment = '%s'\n",
	   tmp->filename, tmp->load_address, tmp->prog_number, tmp->size, tmp->name, tmp->comment);
    tmp = tmp->next;
  }
  return (0);
}

void	my_putchar(char c)
{
  write(1, &c, 1);
}

void	my_putnbr(int nb)
{
  if (nb < 0)
  {
    nb = -nb;
    my_putchar('-');
  }
  if (nb >= 10)
    my_putnbr(nb / 10);
  my_putchar((nb % 10) + '0');
}

void	disp_arena(unsigned char *arena)
{
  int	i;

  i = 0;
  printf("ptr = %x\n", arena);
  while (i + 1 < 1024 * 6)
  {
    my_putnbr(arena[i]);
    i += 1;
  }
}
