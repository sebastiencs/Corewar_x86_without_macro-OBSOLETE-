section .text

global get_args

is_error_in_args:

	push	ebp
	mov	ebp, esp

	push	dword 1			; var i = 1

	cmp	dword [ebp + 8], 2	; si argc < 2
	jl	.EXIT

.LOOP	mov	eax, [ebp + 8]
	cmp	dword [ebp - 4], eax
	jge	.END			; si i >= argc


	mov	esp, ebp
	pop	ebp

	mov	eax, 0
	ret

.END	nop

.EXIT	mov	eax, -1
	ret

get_args:

	push	ebp
	mov	ebp, esp

	push	eax

	push	dword [ebp + 8]
	push	dword [ebp + 12]
;	call	is_error_in_args
	add	esp, 8

	pop	eax

	mov	esp, ebp
	pop	ebp

	mov	eax, 0
	ret

.EXIT	mov	eax, -1
	ret