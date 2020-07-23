;=================================================
; Name: Jasmine Lau
; Email: 
; 
; Lab: lab 5, ex 2
; Lab section: A021
; TA: Jason Goudling
; 
;=================================================
.orig x3000

LD R1, cap
AND R4, R4, #0

START
	LEA R0, prompt
	PUTS

END_START

LOOPY
	GETC
	OUT
	
	ADD R1, R1, #-1
	ADD R2, R1, #-16
	ADD R2, R2, #0
	
	BRz LOOPY
	
	ADD R3, R1, #0
	
	LD R2, ascii
	ADD R0, R0, R2

FROOT
	ADD R3, R3, #0
	BRz POSTER
	
	ADD R0, R0, R0
	ADD R3, R3, #-1
	BRp FROOT

POSTER
	ADD R4, R4, R0
	ADD R1, R1, #0
	BRp LOOPY
	
	ADD R2, R4, #0
	ADD R1, R2, #0
	
	LD R5, toascii
	LD R3, SUB_ADDR
	LD R0, newline
	OUT
	
	JSRR R3
	
	HALT
;=======================================================================
cap			.FILL	#17
ascii		.FILL	#-48
toascii		.FILL 	#48
SUB_ADDR	.FILL	x5000
newline		.FILL	#10
prompt		.STRINGZ "Enter a 16-bit 2's Complement Binary Number: \n"
;=======================================================================

.orig x5000
SUBROUTINE
BACKUP_INIT
	ST R7,backup_R7

	LD R6, char16

BRANCH_PRINT
	ADD R1, R1, #0
	BRzp PRINT_0
	
	ADD R1, R1, #0
	BRn PRINT_1
END_BRANCH_PRINT

NEXT_CH
	ADD R1, R1, R1
	ADD R6, R6, #-1
	
	LD R7, space12
	ADD R7, R6, R7
	BRz SPACE
	
	LD R7, space8
	ADD R7, R6, R7
	BRz SPACE
	
	LD R7, space4
	ADD R7, R6, R7
	BRz SPACE	
END_NEXT_CH

SPACE
	LD R0, space
	OUT
	
	BRnzp POST
END_SPACE

POST
	ADD R6, R6, #0
	BRp BRANCH_PRINT
	
	LD R0, NEWLINE
	OUT
	
	BRnzp END_SUBROUTINE
END_POST

PRINT_0
	AND R0, R0, #0
	ADD R0, R0, R5
	OUT
	
	BRnzp NEXT_CH
END_PRINT_0

PRINT_1
	AND R0, R0, #0
	ADD R0, R0, #1
	ADD R0, R0, R5
	OUT
	
	BRnzp NEXT_CH
END_PRINT_1

END_SUBROUTINE
	LD R7, backup_R7
	
	RET
END_END_SUBROUTINE

;=======================================================================
backup_R7	.FILL	x0
char16		.FILL	#16
space12		.FILL 	#-12
space8		.FILL	#-8
space4		.FILL	#-4
NEWLINE		.FILL	#10
space		.FILL	#32

.END
