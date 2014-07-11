section .data

str1:	db '-d', 0

ok:	db 'OK', 10, 0
no:	db 'NO OK', 10, 0

section .text

extern strcmp
extern is_options
extern is_numbers
extern is_file_dot_cor
extern is_one_file_cor
extern usage
extern get_dump
extern printf
extern my_strcmp

global get_args

global my_putstr

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
        pop ebp

        ret

is_error_in_args:

	push	ebp
	mov	ebp, esp


	push	ecx

	mov	ecx, 1

	cmp	dword [ebp + 8], 2	; si argc < 2
	jl	.EXIT

.LOOP	mov	eax, [ebp + 8]
	cmp	dword ecx, eax
	jge	.ENDL			; si i >= argc

	mov	eax, [ebp + 12]
	push	dword [eax + (ecx * 4)]
	call	is_options
	add	esp, 4
	cmp	eax, 0
	je	.ELSE

.IF	mov	eax, [ebp + 12]
	push	dword [eax + ((ecx + 1) * 4)]
	call	is_numbers
	add	esp, 4
	cmp	eax, -1
	jne	.NOTRET

	push	str1
	mov	eax, [ebp + 12]
	push	dword [eax + (ecx * 4)]
	call	my_strcmp
	add	esp, 8
	cmp	eax, 0
	je	.NOTRET

	jmp	.EXIT

.NOTRET	add	ecx, 2
	jmp	.LOOP


.ELSE	mov	eax, [ebp + 12]
	push	dword [eax + (ecx * 4)]
	call	is_file_dot_cor
	add	esp, 4
	cmp	eax, -1
	jne	.NTRET2

	jmp	.EXIT

.NTRET2	add	ecx, 1
	jmp	.LOOP

.ENDL	push	dword [ebp + 12]
	push	dword [ebp + 8]
	call	is_one_file_cor
	add	esp, 8
	cmp	eax, -1
	je	.EXIT

.END	pop	ecx
	mov	esp, ebp
	pop	ebp
	mov	eax, 0
	ret

.EXIT	pop	ecx
	mov	esp, ebp
	pop	ebp
	mov	eax, -1
	ret

get_args:

	push	ebp
	mov	ebp, esp

	push	dword [ebp + 12]
	push	dword [ebp + 8]
	call	is_error_in_args
	add	esp, 8
	cmp	eax, -1
	je	.USAGE

	push	ok
	call	my_putstr
	add	esp, 4

	push	dword [ebp + 16]
	push	dword [ebp + 12]
	push	dword [ebp + 8]
	call	get_dump
	add	esp, 12

.END	mov	esp, ebp
	pop	ebp
	mov	eax, 0
	ret

.EXIT	mov	esp, ebp
	pop	ebp
	mov	eax, -1
	ret

.USAGE	call	usage
	jmp	.END