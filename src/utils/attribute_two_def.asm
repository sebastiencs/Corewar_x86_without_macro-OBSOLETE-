
%include "corewar.inc"

section .data

mem_size:	dd MEM_SIZE

section .text

extern swap_int

global attribute_two_def

attribute_two_def:

	push	ebp
	mov	ebp, esp

	sub	esp, 8
	; [ebp - 4] p0
	; [ebp - 8] p1

	push	ecx
	push	edx

	mov	eax, [ebp + 8]
	mov	ecx, 0

.L1	cmp	eax, 0
	je	.ENDL1

	cmp	dword [eax + s_champions.load_address], 0
	je	.NEXT1

	mov	edx, [eax + s_champions.load_address]

	cmp	ecx, 0
	jne	.P1

.P0	mov	[ebp - 4], edx
	jmp	.NEXT1

.P1	mov	[ebp - 8], edx
	

.NEXT1	mov	eax, [eax + s_champions.next]
	jmp	.L1

.ENDL1	mov	dword edx, [ebp - 4]
	cmp	dword [ebp - 8], edx
	jge	.NEXT2

	lea	eax, [ebp - 8]
	push	eax
	lea	eax, [ebp - 4]
	push	eax
	call	swap_int
	add	esp, 8

.NEXT2	mov	eax, [ebp - 8]
	sub	eax, dword [ebp - 4]
	cmp	eax, MEM_SIZE / 2
	jle	.ELSE

.IF	mov	edx, 0
	div	dword [ebp + 16]
	add	eax, dword [ebp - 4]
	mov	dword [ebp + 12], eax
	jmp	.ENDIF

.ELSE	mov	edx, eax
	mov	eax, MEM_SIZE
	sub	eax, edx

	mov	edx, 0
	div	dword [ebp + 16]
	add	eax, dword [ebp - 8]
	mov	dword [ebp + 12], eax

.ENDIF	mov	eax, dword [ebp + 8]

.L2	cmp	eax, 0
	je	.ENDL2

	cmp	dword [ebp + 12], 0
	jge	.N2

	mov	edx, dword [ebp + 12]
	add	eax, MEM_SIZE
	mov	[ebp + 12], eax

.N2	cmp	dword [eax + s_champions.load_address], 0
	jne	.NEXTL2

	push	eax

	mov	edx, 0
	mov	eax, dword [ebp + 12]
	div	dword [mem_size]

	pop	eax
	mov	[eax + s_champions.load_address], edx
	push	eax

.IF2	mov	eax, [ebp - 8]
	sub	eax, dword [ebp - 4]
	cmp	eax, MEM_SIZE / 2
	jle	.ELSE2

	mov	eax, dword [ebp + 12]
	sub	eax, dword [ebp - 8]
	add	eax, dword [ebp + 12]
	mov	[ebp + 12], eax
	jmp	.NEXTL2

.ELSE2	mov	eax, dword [ebp + 12]
	sub	eax, dword [ebp - 4]
	add	eax, dword [ebp + 12]
	mov	[ebp + 12], eax

.NEXTL2	pop	eax
	mov	eax, [eax + s_champions.next]
	jmp	.L2

.ENDL2	pop	edx
	pop	ecx
	add	esp, 8
	mov	esp, ebp
	pop	ebp
	ret
