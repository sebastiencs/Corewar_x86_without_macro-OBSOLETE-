
%include "corewar.inc"

section .data

t_corewar:	ISTRUC s_corewar
AT s_corewar.arena,		DD	0
AT s_corewar.info_arena,	DD	0
AT s_corewar.nb_champions,	DD	0
AT s_corewar.champions,		DD	0
AT s_corewar.last_champions,	DD	0
AT s_corewar.last_live_nb,	DD	0
AT s_corewar.last_live_name,	DD	0
AT s_corewar.prog_number_max,	DD	0
AT s_corewar.nbr_cycle_dump,	DD	0
AT s_corewar.nbr_live_cur,	DD	0
AT s_corewar.is_desassembler,	DD	0
AT s_corewar.cycle_to_dir_cur,	DD	0
IEND

nbr: db 'argc = %d argv[1] = %s', 10, 0

section .text

main:

	push	ebp
	mov	ebp, esp

	push	dword [ebp + 8]
	push	dword [ebp + 12]
	push	t_corewar
	call	get_args
	add	esp, 12

	mov	esp, ebp
	pop	ebp

	mov	eax, 0
	ret

.EXIT	mov	eax, -1
	ret

	; push	ebp
	; mov	ebp, esp

	; mov	ecx, [ebp + 8]
	; mov	edx, [ebp + 12]

	; push	ecx
	; push	edx

	; push	dword [edx + 4]
	; push	ecx
	; push	nbr
	; call	printf
	; add	esp, 12

	; mov	esp, ebp
	; pop	ebp

	; mov	eax, 0

	; ret
