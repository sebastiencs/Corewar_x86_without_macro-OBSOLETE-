
%include "corewar.inc"

section .text

extern malloc
extern my_putstr
extern init_arena
extern load_champions_in_arena

extern disp_arena

global load_arena

load_arena:

	push	ebp
	mov	ebp, esp

	mov	edx, dword [ebp + 8]

	mov	dword [edx + s_corewar.nbr_live_cur], 0
	mov	dword [edx + s_corewar.nbr_live_cur], CYCLE_TO_DIE

	push	dword MEM_SIZE
	call	malloc
	add	esp, 4
	cmp	eax, 0
	je	.FAIL
	mov	edx, dword [ebp + 8]
	mov	[edx + s_corewar.arena], eax

	; mov	ebx, [edx + s_corewar.arena]

	; to rm

	; lea	edx, [edx + s_corewar.arena]
	; push	edx
	; push	ecx
	; push	eax
	; call	disp_arena
	; add	esp, 4
	; pop	ecx
	; pop	edx
	


;	mov	ebx, [edx]

	push	dword MEM_SIZE
	call	malloc
	add	esp, 4
	cmp	eax, 0
	je	.FAIL
	mov	edx, dword [ebp + 8]
	mov	[edx + s_corewar.info_arena], eax

	mov	edx, dword [ebp + 8]
	push	dword 0
	push	dword MEM_SIZE
	mov	eax, [edx + s_corewar.arena]
	push	eax
	; push	dword edx + s_corewar.arena
	call	init_arena
	add	esp, 12

	mov	edx, dword [ebp + 8]
	push	dword 0
	push	dword MEM_SIZE
	mov	eax, [edx + s_corewar.info_arena]
	push	eax
	; lea	edx, [edx + s_corewar.info_arena]
	; push	edx
	call	init_arena
	add	esp, 12

	; ; to rm

; 	mov	edx, dword [ebp + 8]
; ;	lea	edx, [edx + s_corewar.info_arena]
; 	push	edx
; 	push	ecx

; 	mov	eax, [edx + s_corewar.info_arena]
; 	push	eax
; 	call	disp_arena
; 	add	esp, 4
; 	pop	ecx
; 	pop	edx
	;
	; ;

.TEST	mov	eax, [ebp + 8]
	push	eax
	mov	edx, [eax + s_corewar.info_arena]
	push	edx
	mov	edx, [eax + s_corewar.arena]
	push	edx
	call	load_champions_in_arena
	add	esp, 12
	cmp	eax, -1
	je	.FAIL

	xor	eax, eax
	jmp	.END

.FAIL	mov	eax, -1

.END	mov	esp, ebp
	pop	ebp
	ret
