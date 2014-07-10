
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
.size:
ENDSTRUC

extern printf
extern get_args
extern is_number
global main

%endif
