;=======================================================================
; Name: Jasmine Lau
; Email: 
; 
; Lab: lab 6, ex 3
; Lab section: A021
; TA: Jason Goulding
; 
;=======================================================================
.orig x3000

LD R1, MANGO
LD R6, SUB_GET_STRING
JSRR R6

LD R1, MANGO
LD R6, SUB_IS_PALINDROME
JSRR R6
	
ADD R4, R4, #0
BRz NOT_PRINT
BRnp YES_PRINT

NOT_PRINT
	LD R0, QUAIL
	OUT
	
	LEA R0, ISNT_PAL_STR
	PUTS
	BRnzp FIN

YES_PRINT
	LD R0, QUAIL
	OUT
	LEA R0, WAS_PAL_STR
	PUTS
	BRnzp FIN
	
FIN	
	HALT
;=======================================================================
MANGO				.FILL STEEN
QUAIL				.FILL x22

SUB_GET_STRING		.FILL x3200
SUB_IS_PALINDROME 	.FILL x3400

WAS_PAL_STR			.STRINGZ " IS a palindrome"
ISNT_PAL_STR		.STRINGZ " IS NOT a palindrome"

.orig x4000
STEEN		.BLKW #100
;=======================================================================
;SUBROUTINE: 
;	SUB_GET_STRING
;
;PARAMETER (R1): 
;	THE SUBROUTINE HAS PROMPTED THE USER TO INPUT A STRING,
;	TERMINATED BY THE [ENTER] KEY (the "sentinel), AND HAS STORED THE 
;	RECIEVED CHARACTERS IN AN ARRAY OF CHARACTERS STARTING AT R1.
;	the array is NULL-terminated; the sentinel character is not stored.
;
;RETURN VALUE (R5): 
;	THE NUMBER OF NON-SENTINEL CHARACTERS READ FROM THE USER
;	R1 contains the starting address of the array unchanged.
;=======================================================================
.orig x3200

ST R1, BACKUP_R1_3200
ST R6, BACKUP_R6_3200
ST R7, BACKUP_R7_3200

LEA R0, PROMPT
PUTS
	

LD R3, ascii
AND R5, R5, x0

NOT R3, R3
ADD R3, R3, #1
	
BEGIN
	GETC
	OUT
	
	ADD R4, R3, R0
	
	BRnp GARY
	BRz END_WHILE
	
GARY
	STR R0, R1, #0

	ADD R1, R1, #1
	ADD R5, R5, #1
	ADD R4, R4, #0
	
	BRnp BEGIN
END_WHILE
	
END_BEGIN
	AND R4, R4, x0
	LEA R0, PLUTO
	
	ADD R4, R4, R5
	ADD R4, R4, #15	
	ADD R4, R4, #15
	ADD R4, R4, #15
	ADD R4, R4, #3
	
	AND R0, R0, x0 
	ADD R0, R0, R4
		
PRINTS
	LD R0, NEWLINE
	
	LEA R0, PRINT
	PUTS
	
	LD R0, QUAIL_3200
	OUT
	
	LD R0, BACKUP_R1_3200
	PUTS
END_PRINTS

LD R1, BACKUP_R1_3200	
LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200
		
RET
		
;=======================================================================
BACKUP_R1_3200		.BLKW	#1
BACKUP_R6_3200		.BLKW	#1
BACKUP_R7_3200		.BLKW	#1

PROMPT				.STRINGZ "Enter a string terminating with [ENTER] \n"
PLUTO				.STRINGZ "Number of characters: \n"
PRINT				.STRINGZ "The string "

QUAIL_3200			.FILL 	x22

NEWLINE				.FILL	'\n'
ascii				.FILL	#10
;=======================================================================
;Subroutine: 
;	SUB_IS_PALINDROME
;
;PARAMETER (R1)
;
;PARAMETER (R5):
;	NUM OF CHARS IN ARRAY
;
;POSTCONDITION: 
;	DETERMINES WETHER STRING AT R1 IS A PALINDROME OR NOT
;
;RETURN VALUE: 
;	R4 1 IF PALINDROME, 0 OTHERWISE
;=======================================================================
.orig x3400

ST R1, BACKUP_R1_3400
ST R6, BACKUP_R6_3400
ST R7, BACKUP_R7_3400

LD R3, SUB_TO_UPPER
JSRR R3

ADD R5, R5, #-1	
ADD R2, R1, #0
ADD R6, R1, #0
ADD R6, R6, R5

APPLE
	LDR R0, R2, #0
	LDR R4, R6, #0
		
	NOT R4, R4
	ADD R4, R4, #1
	ADD R4, R4, R0
	
	BRz YAY
	BRnp NAY
	
	YAY
		ADD R2, R2, #1
		ADD R6, R6, #-1
		
		BRnzp LOWER
		
			LOWER
				ADD R5, R5, #-1
				
				BRp APPLE
				BRz PAST
END_APPLE
	
ADD R5, R5, #0

BRz PAST
BRnp NAY

PAST
	AND R4, R4, x0
	ADD R4, R4, #1
	BRnzp END
	
NAY
	AND R4, R4, x0
	BRnzp END
		
END
	LD R1, BACKUP_R1_3400
	LD R6, BACKUP_R6_3400
	LD R7, BACKUP_R7_3400
RET

;=======================================================================
BACKUP_R1_3400	.BLKW #1
BACKUP_R6_3400	.BLKW #1
BACKUP_R7_3400	.BLKW #1

SUB_TO_UPPER	.FILL x3600
NEWLINE_3400	.FILL '\n'
;=======================================================================
;SUBROUTINE: 
;	SUB_TO_UPPER
;
;Parameter (R1): 
;	Starting address of a null-terminated string'
;
;Postcondition: 
;	The subroutine has converted the string to upper-case in-place
;
;No return value and no output
;=======================================================================
.orig x3600

ST R1, BACK_UP_R1_3600
ST R2, BACK_UP_R2_3600
ST R3, BACK_UP_R3_3600
ST R7, BACK_UP_R7_3600

LD R2, HEX_20
NOT R2, R2

BANANA
	LDR R3, R1, #0
	
	BRz SPLIT
	
	AND R3, R3, R2
	STR R3, R1, #0
	ADD R1, R1, #1
	
	BR BANANA

SPLIT
	LD R1, BACK_UP_R1_3600
	LD R2, BACK_UP_R2_3600
	LD R3, BACK_UP_R3_3600
	LD R7, BACK_UP_R7_3600
RET

;=======================================================================
HEX_20 .FILL x20

BACK_UP_R1_3600 .BLKW #1
BACK_UP_R2_3600 .BLKW #1
BACK_UP_R3_3600 .BLKW #1
BACK_UP_R7_3600 .BLKW #1
;=======================================================================

.end

   
