;=================================================
; Name: Jasmine Lau
; Email:
; 
; Lab: lab 8, ex 1 & 2
; Lab section: A021
; TA: Jason Goulding
; 
;=================================================

; test harness
.orig x3000

LD R6, PRINT_OP_TABLE
JSRR R6		
 
LD R6, FIND_OP
JSRR R6

halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
PRINT_OP_TABLE .fill x3200
FIND_OP .fill x3600
;===============================================================================================
; subroutines:
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE_TABLE
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;				 and corresponding opcode in the following format:
;					ADD = 0001
;					AND = 0101
;					BR = 0000
;					…
; Return Value: None
;-----------------------------------------------------------------------------------------------
.orig x3200

ST R0, backup_R0_3200	
ST R1, backup_R1_3200	
ST R2, backup_R2_3200	
ST R3, backup_R3_3200	
ST R6, backup_R6_3200	
ST R7, backup_R7_3200	

LD R1, opcodes_po_ptr
LD R3, instructions_po_ptr
OUT_LOOP_3200

STRING_PRINT_3200
LDR R0, R3, #0

BRz END_STRING_PRINT_3200
BRn END_OUT_LOOP_3200
OUT

ADD R3, R3, #1
BR STRING_PRINT_3200
END_STRING_PRINT_3200
ADD R3, R3, #1

LEA R0, equal
PUTS

LDR R2, R1, #0

LD R6, sub_print_opcode
JSRR R6

ADD R1, R1, #1

LD R0, newline
OUT

BR OUT_LOOP_3200

END_OUT_LOOP_3200
	LD R0, backup_R0_3200	
	LD R1, backup_R1_3200	
	LD R2, backup_R2_3200	
	LD R3, backup_R3_3200	
	LD R6, backup_R6_3200	
	LD R7, backup_R7_3200

ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE_TABLE local data
backup_R0_3200 .blkw #1
backup_R1_3200 .blkw #1
backup_R2_3200 .blkw #1
backup_R3_3200 .blkw #1
backup_R6_3200 .blkw #1
backup_R7_3200 .blkw #1

sub_print_opcode 	.fill x3400
opcodes_po_ptr		.fill x4000				; local pointer to remote table of opcodes
instructions_po_ptr	.fill x4100				; local pointer to remote table of instructions

newline 			.fill '\n'
equal 				.STRINGZ " = "
;===============================================================================================
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE
; Parameters: R2 containing a 4-bit op-code in the 4 LSBs of the register
; Postcondition: The subroutine has printed out just the 4 bits as 4 ascii 1s and 0s
;				 The output is NOT newline terminated.
; Return Value: None
;-----------------------------------------------------------------------------------------------
.orig x3400

ST R0, backup_R0_3400
ST R1, backup_R1_3400
ST R2, backup_R2_3400				 
ST R7, backup_R7_3400


AND R1, R1, #0
ADD R1, R1, #12

START_LSHIFT_3400
	ADD R2, R2, R2
	ADD R1, R1, #-1
	
	BRz END_LSHIFT_3400
	BR START_LSHIFT_3400
END_LSHIFT_3400
ADD R1, R1, #4

PRINT_BITS_3400
	LD R0, ascii_shift
	ADD R2, R2, #0
	BRn PRINT_ONE_3400
	BR PRINT_ZERO_3400
	
PRINT_ONE_3400
	ADD R0, R0, #1
	OUT
	BR END_PRINT_ZERO_3400
	
PRINT_ZERO_3400
	OUT
END_PRINT_ZERO_3400

ADD R2, R2, R2
ADD R1, R1, #-1

BRz END_PRINT_BITS_3400
BR PRINT_BITS_3400

END_PRINT_BITS_3400		 
	LD R0, backup_R0_3400
	LD R1, backup_R1_3400
	LD R2, backup_R2_3400				 
	LD R7, backup_R7_3400
				 
ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE local data
backup_R0_3400 .blkw #1
backup_R1_3400 .blkw #1
backup_R2_3400 .blkw #1
backup_R7_3400 .blkw #1
ascii_shift .fill #48
;===============================================================================================
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_FIND_OPCODE
; Parameters: None
; Postcondition: The subroutine has invoked the SUB_GET_STRING subroutine and stored a string
; 				as local data; it has searched the AL instruction list for that string, and reported
;				either the instruction/opcode pair, OR "Invalid instruction"
; Return Value: None
;-----------------------------------------------------------------------------------------------
.orig x3600

ST R0, backup_R0_3600
ST R1, backup_R1_3600				 
ST R2, backup_R2_3600
ST R3, backup_R3_3600
ST R4, backup_R4_3600
ST R5, backup_R5_3600				 
ST R7, backup_R7_3600	

START_SUBR_3600

LD R2, arr_loc

LD R6, sub_get_string
JSRR R6

LD R1, opcodes_fo_ptr
LD R2, instructions_fo_ptr

AND R4, R4, #0
CHECK_ALL_INSTRUCTIONS
	LDR R5, R2, #0
	BRn AFTER_SET_FLAG_3600
	LD R3, arr_loc

INNER_CHECK_3600
	LDR R5, R3, #0
	LDR R0, R2, #0
	ADD R0, R5, R0
	BRz SET_FLAG_3600
	LDR R0, R2, #0
	NOT R0, R0
	ADD R0, R0, #1
	ADD R5, R5, R0
	BRz INCREMENT_THEN_LOOP
	BR MOVE_TO_NEXT_INSTRUC_OPCODE
	
INCREMENT_THEN_LOOP
	ADD R2, R2, #1
	ADD R3, R3, #1
	BR INNER_CHECK_3600
	
MOVE_TO_NEXT_INSTRUC_OPCODE
	ADD R1, R1, #1
	ADD_R2_1
	LDR R5, R2, #0
	BRz SECOND_ADD_R2_1
	ADD R2, R2, #1
	BR ADD_R2_1
	
SECOND_ADD_R2_1
	ADD R2, R2, #1
	BR CHECK_ALL_INSTRUCTIONS

SET_FLAG_3600
	ADD R4, R4, #1
	
AFTER_SET_FLAG_3600
	ADD R4, R4, #0
	BRz PRINT_INVALID_3600
	BR PRINT_INSTRUCTION_3600
	
PRINT_INVALID_3600
	LEA R0, invalid_str
	PUTS
	BR END_PRINT_INSTRUCTION_3600
	
PRINT_INSTRUCTION_3600
	LD R0, arr_loc
	PUTS
	
	LEA R0, equal_3600
	PUTS
	
	LDR R2, R1, #0
	
	LD R6, sub_print_opcode_3600
	JSRR R6
	
	LD R0, newline_3600
	OUT
	
END_PRINT_INSTRUCTION_3600
	BR START_SUBR_3600			;hahah what?
	LD R0, backup_R0_3600
	LD R1, backup_R1_3600				 
	LD R2, backup_R2_3600
	LD R3, backup_R3_3600
	LD R4, backup_R4_3600
	LD R5, backup_R5_3600				 
	LD R7, backup_R7_3600
				 
ret
;-----------------------------------------------------------------------------------------------
; SUB_FIND_OPCODE local data
backup_R0_3600 .blkw #1
backup_R1_3600 .blkw #1
backup_R2_3600 .blkw #1
backup_R3_3600 .blkw #1
backup_R4_3600 .blkw #1
backup_R5_3600 .blkw #1
backup_R7_3600 .blkw #1

sub_print_opcode_3600 	.fill x3400
arr_loc 			  	.fill x3700
sub_get_string 			.fill x3800
opcodes_fo_ptr			.fill x4000
instructions_fo_ptr		.fill x4100

newline_3600 			.fill '\n'

invalid_str 			.STRINGZ "Invalid instruction\n"
equal_3600 				.STRINGZ " = "


.orig x3700
user_input .BLKW x100
;===============================================================================================
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameters: R2 - the address to which the null-terminated string will be stored.
; Postcondition: The subroutine has prompted the user to enter a short string, terminated 
; 				by [ENTER]. That string has been stored as a null-terminated character array 
; 				at the address in R2
; Return Value: None (the address in R2 does not need to be preserved)
;-----------------------------------------------------------------------------------------------
.orig x3800

ST R0, backup_R0_3800
ST R1, backup_R1_3800
ST R7, backup_R7_3800

LEA R0, prompt_str
PUTS

GET_STRING_3800
GETC
OUT

LD R1, enter_shift
ADD R1, R0, R1
BRz TERMINATE_ARR_3800

STR R0, R2, #0
ADD R2, R2, #1

BR GET_STRING_3800
TERMINATE_ARR_3800

AND R0, R0, #0
STR R0, R2, #0
				 
LD R0, backup_R0_3800
LD R1, backup_R1_3800
LD R7, backup_R7_3800
				 
ret
;-----------------------------------------------------------------------------------------------
; SUB_GET_STRING local data
backup_R0_3800 .blkw #1
backup_R1_3800 .blkw #1
backup_R7_3800 .blkw #1

prompt_str .STRINGZ "Enter an instruction (ex. ADD):\n"
enter_shift .fill #-10
;==============================================================================================
;-----------------------------------------------------------------------------------------------
; REMOTE DATA
.orig x4000

; opcodes
.FILL #1
.FILL #5
.FILL #0
.FILL #12
.FILL #4
.FILL #4
.FILL #2
.FILL #10
.FILL #6
.FILL #14
.FILL #9
.FILL #12
.FILL #8
.FILL #3
.FILL #11
.FILL #7
.FILL #15
.FILL #13

.orig x4100

; instructions	
.STRINGZ "ADD"
.STRINGZ "AND"
.STRINGZ "BR"
.STRINGZ "JMP"
.STRINGZ "JSR"
.STRINGZ "JSRR"
.STRINGZ "LD"
.STRINGZ "LDI"
.STRINGZ "LDR"
.STRINGZ "LEA"
.STRINGZ "NOT"
.STRINGZ "RET"
.STRINGZ "RTI"
.STRINGZ "ST"
.STRINGZ "STI"
.STRINGZ "STR"
.STRINGZ "TRAP"
.STRINGZ "reserved"
.FILL #-1
;===============================================================================================
.END


