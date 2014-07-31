;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: get_value.asm
;;  Author:   chapui_s
;;  Created:  21/07/2014 19:44:16 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern get_size_param
extern is_direct
extern is_indirect
extern is_register
extern is_good_register
extern read_arena

proc	get_value, core, champions, instruction, param

	_var_	value, pc, size_param, other, idx_mod, param_1

	pushx	ecx, edx

	mov	dword [idx_mod], IDX_MOD

	mov	eax, [param]
	dec	eax
	shl	eax, 2
	mov	edx, [instruction]
	add	edx, s_instruction.params
	add	eax, edx
	mov	eax, [eax]
	mov	[param_1], eax

	mov	eax, [instruction]
	movzx	edx, byte [eax + s_instruction.type]

.IF	invoke	is_register, edx, [param]
	cmp	eax, 1
	jne	.ELSIF1

	invoke	is_good_register, [param_1]
	cmp	eax, 1
	jne	.END

	mov	eax, [champions]
	mov	eax, [eax + s_champions.reg]
	add	eax, [param_1]

	mov	[value], eax
	jmp	.END

.ELSIF1	invoke	is_direct, edx, [param]
	cmp	eax, 1
	jne	.ELSIF2

	mov	eax, [param_1]
	mov	[value], eax
	jmp	.END

.ELSIF2	invoke	is_indirect, edx, [param]
	cmp	eax, 1
	jne	.END

	mov	eax, [champions]
	mov	eax, [eax + s_champions.pc]
	mov	[pc], eax

	invoke	get_size_param, edx
	mov	[size_param], eax

	xor	edx, edx
	mov	eax, [param_1]
	cmp	eax, 0
	jge	.NO
	mov	edx, -1
.NO	idiv	dword [idx_mod]
	mov	[other], edx

	mov	eax, [pc]
	sub	eax, dword [size_param]
	add	eax, dword [other]

	invoke	read_arena, [core], eax, 4
	mov	[value], eax

.END	mov	eax, [value]

	popx	ecx, edx

endproc