section .data

str1:	db '-dump', 0
str2:	db '-n', 0
str3:	db '-a', 0
str4:	db '-d', 0
str5:	db '.cor', 0

str_test: db 'ecx = %d', 10, 0

section .text

global	is_number
global	is_options
global	is_file_dot_cor
global	is_one_file_cor

extern	strcmp

extern printf

my_putstr:

	push ebp
	mov ebp, esp

	push eax
	push ebx
	push edx
	push ecx

	cmp byte [ebp + 8], 0
	je .END

	mov ebx, 1
	mov edx, 1

.LOOP   mov eax, [ebp + 8]
	cmp byte [eax], 0
	je .END
	mov eax, 4
	mov ecx, [ebp + 8]
	int 80h
        inc dword [ebp + 8]
	jmp .LOOP

.END    pop ecx
	pop edx
	pop ebx
	pop eax
	mov esp, ebp
	pop ebp

	ret

my_putnb:

	push ebp
	mov ebp, esp

	push eax
	push ebx
	push ecx
	push edx

	mov eax, 4
	mov ecx, [ebp + 8]
	add ecx, '0'
	mov ebx, 1
	mov edx, 1
	int 80h
	pop ecx
	pop edx
	pop ebx
	pop eax
	mov esp, ebp
	pop ebp

	ret


is_number:

	push	ebp
	mov	ebp, esp

	cmp	dword [ebp + 8], 0	; si ptr == 0
	je	.EXIT

.LOOP	mov	eax, [ebp + 8]
	cmp	byte [eax], 0		; si *ptr == 0
	je	.END

	cmp	byte [eax], '0'
	jl	.EXIT
	cmp	byte [eax], '9'
	jg	.EXIT
	
	inc	dword [ebp + 8]
	jmp	.LOOP


.END	mov	esp, ebp
	pop	ebp
	mov	eax, 0
	ret

.EXIT	mov	esp, ebp
	pop	ebp
	mov	eax, -1
	ret

is_options:

	push	ebp
	mov	ebp, esp

	push	str1
	push	dword [ebp + 8]
	call	strcmp
	add	esp, 8
	cmp	eax, 0
	je	.EXIT

	push	str2
	push	dword [ebp + 8]
	call	strcmp
	add	esp, 8
	cmp	eax, 0
	je	.EXIT

	push	str3
	push	dword [ebp + 8]
	call	strcmp
	add	esp, 8
	cmp	eax, 0
	je	.EXIT

	push	str4
	push	dword [ebp + 8]
	call	strcmp
	add	esp, 8
	cmp	eax, 0
	je	.EXIT

.END	mov	esp, ebp
	pop	ebp
	mov	eax, 0
	ret

.EXIT	mov	esp, ebp
	pop	ebp
	mov	eax, 1
	ret

is_file_dot_cor:

	push	ebp
	mov	ebp, esp

	push	dword 0

.LOOP	mov	eax, [ebp + 8]
	cmp	byte [eax], 0
	je	.ENDL
	inc	dword [ebp + 8]
	inc	dword [ebp - 4]
	jmp	.LOOP

.ENDL	cmp	dword [ebp - 4], 5
	jl	.EXIT

	sub	dword [ebp - 4], 4
	push	str5
	mov	eax, [ebp + 8]
	sub	eax, 4
	push	dword eax
	call	strcmp
	add	esp, 8

	cmp	eax, 0
	jne	.EXIT


.END	add	esp, 4
	mov	esp, ebp
	pop	ebp
	mov	eax, 1
	ret

.EXIT	add	esp, 4
	mov	esp, ebp
	pop	ebp
	mov	eax, -1
	ret

is_one_file_cor:

	push	ebp
	mov	ebp, esp

	mov	ecx, 1
	mov	edx, 0

.LOOP	mov	eax, [ebp + 8]
	cmp	ecx, eax
	jge	.ENDL

	mov	eax, [ebp + 12]
	push	dword [eax + (ecx * 4)]
	call	my_putstr
	add	esp, 4

	mov	eax, [ebp + 12]
	push	dword [eax + (ecx * 4)]
	call	is_file_dot_cor
	add	esp, 4
	cmp	eax, 1
	jne	.NEXT
	add	edx, 1
.NEXT	add	ecx, 1
	jmp	.LOOP

.ENDL	cmp	dword edx, 0
	je	.EXIT

.END	mov	esp, ebp
	pop	ebp
	mov	eax, 0
	ret

.EXIT	mov	esp, ebp
	pop	ebp
	mov	eax, -1
	ret
	