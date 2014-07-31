;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: my_or.asm
;;  Author:   chapui_s
;;  Created:  23/07/2014 22:10:18 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern get_value
extern is_good_register

proc	 my_or, core, champions, instruction

	 _var_	value1, value2, or_value

	 pushx	edx

	 invoke	get_value, [core], [champions], [instruction], 1
	 mov	dword [value1], eax

	 invoke	get_value, [core], [champions], [instruction], 2
	 mov	dword [value2], eax

	 mov	eax, dword [value1]
	 or	eax, dword [value2]
	 mov	dword [or_value], eax

	 mov	eax, [instruction]
	 mov	eax, [eax + s_instruction.params + 8]
	 mov	edx, eax
	 invoke	is_good_register, eax
	 cmp	eax, 1
	 jne	.CARRY

	 mov	eax, edx
	 mov	edx, 4
	 mul	edx

	 mov	edx, [champions]
	 mov	edx, [edx + s_champions.reg]
	 add	edx, eax

	 mov	eax, dword [or_value]

	 mov	dword [edx], eax

.CARRY	 mov	eax, [champions]

	 cmp	dword [or_value], 0
	 je	.ONE

	 mov	dword [eax + s_champions.carry], 0
	 jmp	.END

.ONE	 mov	dword [eax + s_champions.carry], 1

.END	 xor	eax, eax
	 popx	edx

endproc