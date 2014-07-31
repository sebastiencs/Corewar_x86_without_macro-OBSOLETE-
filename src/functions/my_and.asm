;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_and.asm
;;  Author:   chapui_s
;;  Created:  21/07/2014 20:06:39 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern get_value
extern is_good_register

proc	my_and, core, champions, instruction

	_var_	value1, value2

	pushx	ecx, edx

	invoke	get_value, [core], [champions], [instruction], 1
	mov	[value1], eax

	invoke	get_value, [core], [champions], [instruction], 2
	mov	[value2], eax

	mov	eax, [value1]
	and	eax, dword [value2]
	mov	ecx, eax

	mov	eax, [instruction]
	mov	eax, [eax + s_instruction.params + 8]
	mov	edx, eax
	invoke	is_good_register, eax
	cmp	eax, 1
	jne	.NO

	mov	eax, [champions]
.TEST	mov	eax, [eax + s_champions.reg]

	mov	[eax + (edx * 4)], ecx

.NO	cmp	ecx, 0
	je	.ONE

	mov	edx, 0
	jmp	.END

.ONE	mov	edx, 1

.END	mov	eax, [champions]
	mov	[eax + s_champions.carry], edx

	xor	eax, eax

	popx	ecx, edx

endproc