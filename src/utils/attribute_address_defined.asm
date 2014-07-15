
%include "corewar.inc"

section .text

extern is_addr_already_define
extern attribute_one_def
extern attribute_two_def

global attribute_address_defined

attribute_address_defined:

	push	ebp
	mov	ebp, esp

	sub	esp, 4
	push	edx
	; [ebp - 4] nb_already_defined

	push	dword [ebp + 8]
	call	is_addr_already_define
	add	esp, 4
	mov	[ebp - 4], eax

.IF	cmp	dword [ebp - 4], 1
	jne	.IF2

	push	dword [ebp + 16]
	push	dword [ebp + 8]
	call	attribute_one_def
	add	esp, 8

.IF2	cmp	dword [ebp + 12], 2
	je	.IF3

	cmp	dword [ebp - 4], 2
	jne	.IF3

	mov	eax, dword [ebp + 12]
	dec	eax
	push	eax
	push	dword [ebp + 16]
	push	dword [ebp + 8]
	call	attribute_two_def
	add	esp, 12

.IF3	cmp	dword [ebp + 12], 3
	je	.ENDIF

	cmp	dword [ebp - 4], 3
	jne	.ENDIF

	; A TERMINER !

.ENDIF	mov	eax, [ebp + 8]

.LOOP	cmp	eax, 0
	je	.ENDL

	mov	edx, [eax + s_champions.load_address]
	mov	[eax + s_champions.pc], edx
	mov	eax, [eax + s_champions.next]
	jmp	.LOOP

.ENDL	xor	eax, eax
	pop	edx
	add	esp, 4
	mov	esp, ebp
	pop	ebp
	ret
