;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: fulfil_params.asm
;;  Author:   chapui_s
;;  Created:  19/07/2014 23:54:56 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

str1: db 'tmp_type = %d', 10, 0

section .text

extern fulfil_dir
extern read_arena

proc   fulfil_param, core, champion, instruction

       _var_	decal, tmp_type, other, param_ptr, mem_size

       pushx	eax, ecx, edx

       mov	dword [mem_size], MEM_SIZE

       mov	eax, [instruction]
       movzx	edx, byte [eax + s_instruction.type]
       shr	edx, 2
       shl	edx, 2
       mov	dword [tmp_type], 0
       mov	byte [tmp_type], dl

       mov	eax, [champion]
       mov	eax, [eax + s_champions.pc]
       add	eax, 2
       mov	[decal], eax

       mov	eax, [instruction]
.TEST  add	eax, s_instruction.params
       mov	[param_ptr], eax

       mov	ecx, 0

.LOOP  mov	eax, [tmp_type]
       and	eax, 0b11000000
       cmp	eax, 0
       je	.ENDL

       mov	eax, [tmp_type]
       shr	eax, 6
       mov	[other], eax

       IF	dword [other], e, 1

       		invoke	read_arena, [core], [decal], 1
		mov	edx, [param_ptr]
		add	edx, ecx
		mov	[edx], eax
		inc	dword [decal]

       ELSEIF	dword [other], e, 0b10

       		lea	eax, [decal]
       		invoke	fulfil_dir, [core], [champion], [instruction], eax
		mov	edx, [param_ptr]
		add	edx, ecx
		mov	[edx], eax

       ELSE

		invoke	read_arena, [core], [decal], 2
		mov	edx, [param_ptr]
		add	edx, ecx
		mov	[edx], eax
		add	dword [decal], 2

       ENDIF

       mov	eax, [tmp_type]
       shl	al, 2
       mov	[tmp_type], eax
       add	ecx, 4
       jmp	.LOOP

.ENDL  xor	edx, edx
       mov	eax, [decal]
       cmp	eax, 0
       jge	.NO
       mov	edx, -1
.NO    div	dword [mem_size]
       mov	eax, [champion]
       mov	[eax + s_champions.pc], edx

       popx	eax, ecx, edx

endproc