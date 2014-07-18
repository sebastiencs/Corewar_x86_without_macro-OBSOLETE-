
%include "corewar.inc"

section .text

extern get_name_comment_champions
extern read
extern check_place_arena
extern check_size_read
extern my_putstr

extern disp_arena

global load_file_in_arena

load_file_in_arena:

	push	ebp
	mov	ebp, esp

	sub	esp, 20
	; [ebp - 4]  fd
	; [ebp - 8]  buf
	; [ebp - 12] size
	; [ebp - 16] i
	; [ebp - 20] s_read
	push	ebx
	push	ecx
	push	edx

	mov	eax, [ebp + 16]

.LOOP	cmp	eax, 0
	je	.END

	mov	dword [ebp - 12], 0
	mov	edx, [eax + s_champions.load_address]
	mov	[ebp - 16], edx

	push	eax
	lea	edx, [ebp - 4]
	push	dword edx
	push	eax
	call	get_name_comment_champions
	add	esp, 8
	cmp	eax, -1
	je	.FAIL
	pop	eax

.L2	push	eax

	mov	ebx, [ebp - 4]
	lea	ecx, [ebp - 8]
	mov	edx, 1
	mov	eax, 3			; read
	int	0x80

	mov	dword [ebp - 20], eax

	cmp	eax, 0
	jle	.ENDL2

	pop	eax
	inc	dword [ebp - 12]

	mov	edx, [ebp - 16]
	mov	ebx, [ebp + 8]
	add	ebx, edx
	mov	edx, 0
	mov	dl, byte [ebp - 8]
	mov	[ebx], byte dl

	; push	dword [ebp + 12]
	; call	disp_arena
	; add	esp, 4
	push	eax
	lea	edx, [ebp - 16]
	push	dword edx
.TEST2	mov	edx, [eax + s_champions.prog_number]
	push	edx
	push	dword [ebp + 12]
	; mov	edx, [ebp + 12]
	; push	edx
.TEST	call	check_place_arena
	add	esp, 12
	cmp	eax, -1
	je	.FAIL

	pop	eax
	cmp	dword [ebp - 16], (MEM_SIZE - 1)
	jne	.NEXT

	mov	dword [ebp - 16], 0

.NEXT	jmp	.L2

	;push	eax
.ENDL2	pop	eax
	push	eax
	push	dword [ebp - 20]
	push	dword [ebp - 4]

	push	eax

	;push	dword [ebp + 16]
	push	dword [ebp - 12]
	call	check_size_read
	add	esp, 16
	cmp	eax, -1
	je	.FAIL

	pop	eax
.TEST4	mov	eax, [eax + s_champions.next]
	jmp	.LOOP

.FAIL	mov	eax, -1

.END	pop	edx
	pop	ecx
	pop	ebx
	add	esp, 20
	mov	esp, ebp
	pop	ebp
	ret
