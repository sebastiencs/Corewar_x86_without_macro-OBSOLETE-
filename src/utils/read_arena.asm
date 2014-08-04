;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: read_arena.asm
;;  Author:   chapui_s
;;  Created:  19/07/2014 22:37:23 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern to_negativ

proc	read_arena, core, index, n_to_read

	_var_	value, mem_size

	pushx	ecx, edx

	mov	dword [mem_size], MEM_SIZE
	mov	ecx, 0
	mov	dword [value], 0

.L1	cmp	dword [index], 0
	jge	.L2

	add	dword [index], MEM_SIZE
	; mov	eax, [index]
	; add	eax, MEM_SIZE
	; mov	[index], eax
	jmp	.L1

.L2	cmp	ecx, [n_to_read]
	jge	.ENDL2

	; mov	eax, [value]
	; shl	eax, 8
	; mov	[value], eax
	shl	dword [value], 8

	mov	eax, [index]
	add	eax, ecx
	; xor	edx, edx
	; cmp	eax, 0
	; jge	.NO
	; mov	edx, -1
	cdq
	idiv	dword [mem_size]

	mov	eax, [core]
	mov	eax, [eax + s_corewar.arena]
	add	eax, edx
	movzx	edx, byte [eax]

	mov	eax, [value]
	add	eax, edx
	mov	[value], eax
	; mov	eax, [value]
	; add	dword [edx], eax
	; add	eax, edx
	;add	[value], edx

	inc	ecx
	jmp	.L2

.ENDL2	invoke	to_negativ, [value], [n_to_read]
	mov	[value], eax

	cmp	dword [n_to_read], 1
	jne	.ELSE

	cmp	dword [value], 16
	jg	.DO

	cmp	dword [value], 1
	jl	.DO

	jmp	.ELSE

.DO	mov	eax, 16
	jmp	.END

.ELSE	mov	eax, [value]

.END	popx	ecx, edx

endproc