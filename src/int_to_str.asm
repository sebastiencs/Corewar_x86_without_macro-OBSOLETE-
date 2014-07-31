;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;  Filename: int_to_str.asm
;;  Author:   chapui_s
;;  Created:  18/07/2014 19:51:04 (+08:00 UTC)
;;  Updated:  19/07/2014 17:09:47 (+08:00 UTC)
;;  URL:      https://github.com/sebastiencs/
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .data

ten:	dd 10

section .text

proc	get_size_nb, nb_param

	_var_	nb, size

	pushx	ecx, edx, ebx

	mov	dword [size], 1
	mov	eax, [nb_param]
	mov	edx, -1

	IF	eax, l, 0

		imul	edx
	ENDIF

	mov	[nb], eax

.LOOP	cmp	dword [nb], 10
	jl	.ENDL

	mov	eax, [size]
	mul	dword [ten]
	mov	[size], eax

	mov	eax, [nb]
	mov	edx, 0
	div	dword [ten]
	mov	[nb], eax

	jmp	.LOOP

.ENDL	mov	eax, [size]
	popx	ecx, edx, ebx

endproc

proc	int_to_str, number, string

	_var_	size_nb

	mov	ecx, 0
	mov	eax, [string]
	invoke	get_size_nb, [number]
	mov	[size_nb], eax

.LOOP	cmp	dword [size_nb], 0
	jle	.ENDL

	mov	eax, [number]
	mov	edx, 0
	div	dword [size_nb]
	mov	edx, eax
	add	edx, '0'

	mov	eax, [string]
	add	eax, ecx
	mov	byte [eax], dl

	mov	eax, [number]
	mov	edx, 0
	div	dword [size_nb]

	mul	dword [size_nb]
	mov	edx, [number]
	sub	edx, eax
	mov	[number], edx

	mov	edx, 0
	mov	eax, [size_nb]
	div	dword [ten]
	mov	[size_nb], eax

	inc	ecx
	jmp	.LOOP

.ENDL	mov	eax, [string]
	add	eax, ecx
	mov	byte [eax], 0

	sub	eax, ecx

endproc
