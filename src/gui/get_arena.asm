;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;  Filename: get_arena.asm
;;  Author:   chapui_s
;;  Created:  16/07/2014 22:09:30 (+08:00 UTC)
;;  Updated:  18/07/2014 12:44:37 (+08:00 UTC)
;;  URL:      https://github.com/sebastiencs/
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "corewar.inc"

section .text

extern disp_arena
extern disp_gui

proc	get_arena, core, gui

	_var_	_pause, j

	mov	dword [j], 0
	mov	dword [_pause], 0

.LOOP	mov	eax, [j]
	cmp	eax, 1000
	jge	.ENDPROC

	invoke	disp_arena, [core], [gui], [j], 0
	_check_	.FAIL, -1

	inc	dword [j]
	jmp	.LOOP

	xor	eax, eax
	jmp	.ENDPROC

.FAIL	mov	eax, -1

endproc
