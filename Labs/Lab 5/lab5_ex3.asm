;=================================================
; Name: Jasmine Lau
; Email: jlau053@ucr.edu
; 
; Lab: lab 5, ex 3
; Lab section: A021
; TA: Jason Goulding
; 
;=================================================
.orig x3000
	LD R3, SUB_ADDR
	JSRR R3
	
	LD R5, SUBMARINE
	JSRR R5
	
SUB_ADDR	.FILL	x5000
SUBMARINE	.FILL	x3300
;=======================================================================
;OUT
;=======================================================================
.orig x3300
ST R0, BACK_R0_3200
ST R2, BACK_R2_3200
ST R3, BACK_R3_3200
ST R4, BACK_R4_3200
ST R7, BACK_R7_3200

LEA	R0, MANGO
PUTS

LD R4, COUNT
LD R3, CHAR16
LD R6, COVER

WHILE
	AND R5, R2, R6
	BRn OPP
	
	LD R0, K3
	OUT
	
	ADD R2, R2, R2
	ADD R4, R4, #-1
	ADD R3, R3, #-1
	BRz FIN
		ADD R4, R4, #0
		BRp WHILE

LD R0, STAR
OUT

LD R4, COUNT
BRnzp WHILE

OPP
	LD R0, K4
	OUT
	
	ADD R2, R2, R2
	ADD R4, R4, #-1
	ADD R3, R3, #-1
	BRz FIN
	
ADD R4, R4, #0
BRp WHILE

LD R0, STAR
OUT

LD R4, COUNT
BRnzp WHILE

FIN
	LEA R0, NEW
	PUTS

LD R0, BACK_R0_3200
LD R2, BACK_R2_3200
LD R3, BACK_R3_3200
LD R4, BACK_R4_3200
LD R7, BACK_R7_3200
	
RET
;=======================================================================
BACK_R0_3200 .BLKW #1
BACK_R2_3200 .BLKW #1
BACK_R3_3200 .BLKW #1
BACK_R4_3200 .BLKW #1
BACK_R7_3200 .BLKW #1

STAR .FILL x20
NEW .STRINGZ "\n"
MANGO .STRINGZ "b"

COUNT.FILL #4
CHAR16 .FILL #16

K3 .FILL x30
K4 .FILL x31

COVER .FILL x8000

;=======================================================================
;IN
;=======================================================================
.orig x5000

SUBROUTINE
BACKUP_INIT
	ST R0,backup_R0
	ST R1,backup_R1
	ST R2,backup_R2
	ST R3,backup_R3
	ST R4,backup_R4
	ST R5,backup_R5
	ST R7,backup_R7
ERROR_CHECK
	LD R7, check
	ADD R0, R0, R7
	BRz LOOPY
	
	LEA R0, newline
	PUTS
	
	LEA R0, error
	PUTS
	
	LEA R0, newline
	PUTS
	
	BRnzp main

ZERO
	ADD R6, R6, #-1
	ADD R5, R0, R6
	BRz GO
END_ZERO

ONE
	LD R6, ascii
	ADD R5, R0, R6
	BRz GO
END_ONE

WRONG
	LEA R0, newline
	PUTS
	
	LEA R0, incorrect
	PUTS
END_WRONG

ENTER
	ADD R1, R1, #1
	BRnzp LOOPY
END_ENTER

START
	LEA R0, prompt
	PUTS
main
	LD R1, cap
	AND R4, R4, #0
	
LOOPY
	GETC
	OUT
	
	ADD R1, R1, #-1
	ADD R2, R1, #-16
	ADD R2, R2, #0
	BRz ERROR_CHECK
	
	LD R7, spacech
	ADD R6, R0, R7
	BRz ENTER
	
	LD R6, ascii
	ADD R5, R0, R6
	BRnp ZERO
	
	ADD R6, R6, #-1
	ADD R5, R0, R6
	BRnp ONE

GO
	ADD R5, R0, R6
	ADD R3, R1, #0
	
	LD R2, ascii
	ADD R0, R0 ,R2
END_GO

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
	;LD R3, SUB_ADDR
	LD R0, newline
	OUT
HALT
BRANCH_PRINT
	ADD R1, R1, #0
	BRzp PRINT_0
	
	ADD R1, R1, #0
	BRn PRINT_1

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

POST
	ADD R6, R6, #0
	BRp BRANCH_PRINT
	
	LD R0, NEWLINE
	OUT
	
	BRnzp END_SUBROUTINE
	
PRINT_0
	AND R0, R0, #0
	ADD R0, R0, R5
	OUT
	
	BRnzp NEXT_CH

PRINT_1
	AND R0, R0, #0
	ADD R0, R0, #1
	ADD R0, R0, R5
	OUT
	
	BRnzp NEXT_CH

SPACE
	LD R0, space
	OUT
	
	BRnzp POST
	
END_SUBROUTINE
	LD R7, backup_R7
	
RET

;=======================================================================
check		.FILL	#-98
cap			.FILL	#17
ascii		.FILL	#-48
toascii		.FILL 	#48
spacech		.FILL	#-32

newline		.STRINGZ "\n"
prompt		.STRINGZ "Enter a 16-bit 2's Complement Binary Number: \n"
incorrect	.STRINGZ "'0' or '1' or a space is needed \n"
error		.STRINGZ "First character needs to be 'b' \n"

;backup_R7	.FILL	x0
char16		.FILL	#16
space12		.FILL 	#-12
space8		.FILL	#-8
space4		.FILL	#-4
NEWLINE		.FILL	#10
space		.FILL	#32

backup_R0	.BLKW 	#1
backup_R1 	.BLKW 	#1
backup_R2 	.BLKW 	#1
backup_R3 	.BLKW 	#1
backup_R4	.BLKW 	#1
backup_R5 	.BLKW 	#1
backup_R7 	.BLKW	#1
;=======================================================================

.END
