section .data

msg:	db 'usage: ./corewar [-dump nbr_cycle] [[-n prog_number] [-a load_address] prog_name] ...', 10, 0

section .text

global	usage

extern	my_putstr

usage:

	push	ebp
	mov	ebp, esp

	push	msg
	call	my_putstr
	add	esp, 4

	mov	esp, ebp
	pop	ebp
	mov	eax, 1
	ret
