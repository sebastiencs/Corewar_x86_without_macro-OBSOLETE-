
%ifndef COREWAR_INC
 %define COREWAR_INC

STRUC		s_corewar
.arena:			RESD	1		; char *
.info_arena:		RESD	1		; char *
.nb_champions:		RESD	1		; unsigned int
.champions:		RESD	1		; t_champions *
.last_champions:	RESD	1		; t_champions *
.last_live_nb:		RESD	1		; int
.last_live_name:	RESD	1		; char *
.prog_number_max:	RESD	1		; unsigned int
.nbr_cycle_dump:	RESD	1		; int
.nbr_live_cur:		RESD	1		; int
.is_desassembler:	RESD	1		; int
.cycle_to_dir_cur:	RESD	1		; int
ENDSTRUC

STRUC		s_champions
.filename:		RESD	1		; char *
.size:			RESD	1		; int
.prog_number:		RESD	1		; unsigned int
.load_address:		RESD	1		; unsigned int
.name:			RESD	1		; char *
.comment:		RESD	1		; char *
.reg:			RESD	1		; int *
.pc:			RESD	1		; int
.carry:			RESD	1		; unsigned int
.last_live:		RESD	1		; unsigned int
.cycle_to_wait:		RESD	1		; int
.color_gui:		RESD	1		; int
.next:			RESD	1		; s_champions *
ENDSTRUC

STRUC		s_gui
.screen:		RESD	1		; SDL_Surface *
.byte_arena:		RESD	1		; SDL_Surface *
.background:		RESD	1		; SDL_Surface *
.players:		RESD	5		; SDL_Surface *
.font:			RESD	1		; TTF_Font *
.font_info:		RESD	1		; TTF_Font *
.list_pc:		RESD	1		; int *
.pos_background:	RESD	2		; SDL_Rect
.my_color:		RESD	1		; SDL_Color
ENDSTRUC

extern printf
;extern get_args
extern is_number
global main

%define SIZE_S_COREWAR		(48)
%define SIZE_S_CHAMPIONS	(52)
%define MALLOC_FAILED		'error: malloc failed !', 10, 0

%define MEM_SIZE		(6 * 1024)
%define CYCLE_TO_DIE		(1536)
%define COREWAR_EXEC_MAGIC	(0xea83f3)
%define PROG_NAME_LENGTH	(128)
%define COMMENT_LENGTH		(2048)
%define REG_NUMBER		(16)

%define O_RDONLY		(0)
%define SEEK_SET		(0)
%define SDL_INIT_VIDEO		(32)

%endif
