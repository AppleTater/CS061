;=================================================
; Name: Jasmine Lau
; Email: jlau053@ucr.edu
; 
; Lab: lab 6, ex 2
; Lab section: A021
; TA: Jason Goudling
; 
;=================================================
.orig x3000

LD R1, STRING_PTR
LD R7, SUB_GET_STRING_PTR
JSRR R7

LD R7, SUB_IS_PALINDROME_PTR
JSRR R7

;LD R0, STRING_PTR
;PUTS

HALT
;=======================================================================
SUB_GET_STRING_PTR		.FILL		x3200
SUB_IS_PALINDROME_PTR	.FILL		x3400
STRING_PTR				.FILL		STRING

.ORIG x4000
STRING .BLKW #100

;=======================================================================

;-----------------------------------------------------------------------
; Subroutine: SUB_GET_STRING

; Parameter (R1): The starting address of a null-terminated string

; Parameter (R5): The number of characters in the array.

; Postcondition: The subroutine has determined whether the string at (R1) is
; a palindrome or not, and returned a flag to that effect.

; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;-----------------------------------------------------------------------
.orig x3200

;ST R0, BACKUP_R0_3200
;ST R1, BACKUP_R1_3200
;ST R2, BACKUP_R2_3200
;ST R3, BACKUP_R3_3200
;ST R4, BACKUP_R4_3200
;ST R5, BACKUP_R5_3200
;ST R6, BACKUP_R6_3200
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
	
	
;LD R0, BACKUP_R0_3200
;LD R1, BACKUP_R1_3200
;LD R2, BACKUP_R2_3200
;LD R3, BACKUP_R3_3200
;LD R4, BACKUP_R4_3200
;LD R5, BACKUP_R5_3200
;LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200

RET

;=======================================================================
;BACKUP_R0_3200		.BLKW	#1
;BACKUP_R1_3200		.BLKW	#1
;BACKUP_R2_3200		.BLKW	#1
;BACKUP_R3_3200		.BLKW	#1
;BACKUP_R4_3200		.BLKW	#1
;BACKUP_R5_3200		.BLKW	#1
;BACKUP_R6_3200		.BLKW	#1
BACKUP_R7_3200		.BLKW	#1

prompt		.STRINGZ		"Enter a string, terminating with newline:\n"

nothing		.FILL			#0
;=======================================================================

;-----------------------------------------------------------------------
; Subroutine: SUB_IS_PALINDROME

; Parameter (R1): The starting address of a null-terminated string

; Parameter (R5): The number of characters in the array.

; Postcondition: The subroutine has determined whether the string at (R1) is
; a palindrome or not, and returned a flag to that effect.

; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;-----------------------------------------------------------------------

.orig x3400

;ST R0, BACKUP_R0_3400
;ST R1, BACKUP_R1_3400
;ST R2, BACKUP_R2_3400
;ST R3, BACKUP_R3_3400
;ST R4, BACKUP_R4_3400
;ST R5, BACKUP_R5_3400
;ST R6, BACKUP_R6_3400
ST R7, BACKUP_R7_3400

ADD R5, R5, #-1
ADD R2, R1, #0
ADD R6, R1, #0
ADD R6, R6, R5

APPLE
	LDR R0, R2, #0
	LDR R4, R6, #0
	
	NOT R4, R4
	ADD R4, R4, #1
	ADD R4, R4, #0
	
	BRz YES
	BRnp NEGATIVE
	
	YES
		ADD R2, R2, #1
		ADD R6, R6, #-1
		
		BRnzp DECREASE
		
	DECREASE
		ADD R5, R5, #-1
		BRp APPLE
				
		BRz PAST
END_APPLE

ADD R5, R5, #0

BRz PAST
BRnp NEGATIVE

PAST
	AND R4, R4, x0
	ADD R4, R4, #1
BRnzp THE_END

NEGATIVE
AND R4, R4, x0
BRnzp THE_END
.end
