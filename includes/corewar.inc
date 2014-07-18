
%ifndef COREWAR_INC
 %define COREWAR_INC

 %include "macro.inc"

struc		s_corewar
 .arena:		resd	1		; char *
 .info_arena:		resd	1		; char *
 .nb_champions:		resd	1		; unsigned int
 .champions:		resd	1		; t_champions *
 .last_champions:	resd	1		; t_champions *
 .last_live_nb:		resd	1		; int
 .last_live_name:	resd	1		; char *
 .prog_number_max:	resd	1		; unsigned int
 .nbr_cycle_dump:	resd	1		; int
 .nbr_live_cur:		resd	1		; int
 .is_desassembler:	resd	1		; int
 .cycle_to_dir_cur:	resd	1		; int
endstruc

struc		s_champions
 .filename:		resd	1		; char *
 .size:			resd	1		; int
 .prog_number:		resd	1		; unsigned int
 .load_address:		resd	1		; unsigned int
 .name:			resd	1		; char *
 .comment:		resd	1		; char *
 .reg:			resd	1		; int *
 .pc:			resd	1		; int
 .carry:		resd	1		; unsigned int
 .last_live:		resd	1		; unsigned int
 .cycle_to_wait:	resd	1		; int
 .color_gui:		resd	1		; int
 .next:			resd	1		; s_champions *
endstruc

struc		s_gui
 .screen:		resd	1		; SDL_Surface *
 .byte_arena:		resd	1		; SDL_Surface *
 .background:		resd	1		; SDL_Surface *
 .players:		resd	5		; SDL_Surface[5] *
 .font:			resd	1		; TTF_Font *
 .font_info:		resd	1		; TTF_Font *
 .list_pc:		resd	1		; int *
 .pos_background:	resd	2		; SDL_Rect
 .my_color:		resd	1		; SDL_Color
endstruc

struc		SDL_Rect
 .x:			resw	1
 .y:			resw	1
 .w:			resw	1
 .h:			resw	1
endstruc

struc		SDL_Color
 .r:			resb	1
 .g:			resb	1
 .b:			resb	1
 .unused:		resb	1
endstruc

extern printf
extern is_number
global main

 %define SIZE_S_COREWAR		(48)
 %define SIZE_S_CHAMPIONS	(52)
 %define MALLOC_FAILED		'error: malloc failed !', 10, 0

 %define MAX_PC			(15000)
 %define WIN_X			(1345)
 %define WIN_Y			(800)
 %define MEM_SIZE		(6 * 1024)
 %define CYCLE_TO_DIE		(1536)
 %define COREWAR_EXEC_MAGIC	(0xea83f3)
 %define PROG_NAME_LENGTH	(128)
 %define COMMENT_LENGTH		(2048)
 %define REG_NUMBER		(16)

 %define O_RDONLY		(0)
 %define SEEK_SET		(0)
 %define SDL_INIT_VIDEO		(32)
 %define SDL_HWSURFACE		(1)

%endif
