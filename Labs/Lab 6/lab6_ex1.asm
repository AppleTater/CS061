;=================================================
; Name: Jasmine Lau
; Email: 
; 
; Lab: lab 6, ex 1
; Lab section: 
; TA: Jason Goulding
; 
;=================================================
.orig x3000

LD R1, STRING_PTR
LD R7, SUB_GET_STRING_PTR
JSRR R7

LD R0, STRING_PTR
PUTS

HALT
;=======================================================================
SUB_GET_STRING_PTR	.FILL		x3200
STRING_PTR			.FILL		STRING

.ORIG x3400
STRING .BLKW #100
;=======================================================================

;-----------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R1): The starting address of the character array

; Postcondition: The subroutine has prompted the user to input a string,
; 	terminated by the [ENTER] key (the "sentinel"), and has stored
; 	the received characters in an array of characters starting at (R1).
; 	the array is NULL-terminated; the sentinel character is NOT stored.

; Return Value (R5): The number of non-sentinel characters read from the 
;	user.

; R1 contains the starting address of the array unchanged.
;-----------------------------------------------------------------------

.orig x3200

ST R1, BACKUP_R1_3200
ST R7, BACKUP_R7_3200

AND R2, R2, x0
AND R5, R5, x0
AND R3, R3, x0

ADD R2, R1, x0

LEA R0, prompt
PUTS

GRAPE
	GETC
	OUT
	
	ADD R3, R0, x0
	ADD R3, R3, #-10
	
	BRz TOMATO
	STR R0, R2, #0
	ADD R2, R2, x1
	ADD R5, R5, x1
	
	BRnp GRAPE
	
TOMATO
	LD R0, nothing
	STR R0, R2, #0
	
	
LD R1, BACKUP_R1_3200
LD R7, BACKUP_R7_3200

RET

;=======================================================================
BACKUP_R1_3200		.BLKW	#1
BACKUP_R7_3200		.BLKW	#1

prompt				.STRINGZ 	"Enter a string, terminating with newline:\n"

nothing				.FILL	#0
;=======================================================================

.end
