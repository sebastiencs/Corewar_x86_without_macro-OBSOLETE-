
%include "corewar.inc"

section .data

str1:
db 'error: malloc', 10, 0

t_gui:
istruc	s_gui
  times 14	dd	0
iend

section .text

extern SDL_Init
extern my_putstr
extern malloc

	push	ebp
	mov	ebp, esp

	push	SDL_INIT_VIDEO
	call	SDL_Init
	add	esp, 4

	mov	esp, ebp
	pop	ebp
	ret
