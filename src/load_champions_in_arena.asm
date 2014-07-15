
%include "corewar.inc"

section .data

str1:	db 'error: too many programmes (max = 4)', 10, 0

section .text

extern load_file_in_arena
extern init_values_champions
extern find_max_prog_number
extern my_putstr

extern disp_arena

global load_champions_in_arena

load_champions_in_arena:

	push	ebp
	mov	ebp, esp

	push	edx

	; mov	eax, [ebp + 16]
	; mov	eax, [eax + s_corewar.champions]
	; push	dword [eax + s_champions.filename]
	; call	my_putstr
	; add	esp, 4



	mov	eax, [ebp + 16]
	mov	eax, [eax + s_corewar.champions]
	push	eax
	push	dword [ebp + 12]
	push	dword [ebp + 8]
	call	load_file_in_arena
	add	esp, 12
	cmp	eax, -1
	je	.FAIL

	mov	eax, [ebp + 16]
	push	dword [eax + s_corewar.champions]
	call	init_values_champions
	add	esp, 4

	mov	eax, [ebp + 16]
	push	dword [eax + s_corewar.champions]
	call	find_max_prog_number
	add	esp, 4
	mov	edx, eax
	mov	eax, [ebp + 16]
	mov	[eax + s_corewar.prog_number_max], edx


;
;
;
;	DOIT AJOUTER LES CYCLES TO WAIT
;
;

	cmp	dword [eax + s_corewar.nb_champions], 4
	jg	.FAILNB


	; push	ebx
	; push	ecx
	; push	edx
	; push	dword [ebp + 8]
	; call	disp_arena
	; add	esp, 4
	; pop	edx
	; pop	ecx
	; pop	ebx

	; push	ebx
	; push	ecx
	; push	edx
	; push	dword [ebp + 12]
	; call	disp_arena
	; add	esp, 4
	; pop	edx
	; pop	ecx
	; pop	ebx


	xor	eax, eax
	jmp	.END

.FAILNB	push	str1
	call	my_putstr
	add	esp, 4
.FAIL	mov	eax, -1

.END	pop	edx
	mov	esp, ebp
	pop	ebp
	ret
