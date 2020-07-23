;=================================================
; Name: Jasmine Lau
; Email: 
; 
; Lab: lab 7, ex 1
; Lab section: A021
; TA: Jason Goulding
; 
;=================================================
.orig x3000

LD R6, FILL
JSRR R6

ADD R1, R1, #1
LD R6, PRINT_DEC
JSRR R6

HALT
;=======================================================================
FILL .FILL x3200

PRINT_DEC .FILL x3400
;=======================================================================
.orig x3200   

ST R7, BACKUP_R7_3200
LD R1, val
LD R7, BACKUP_R7_3200
RET
;=======================================================================
BACKUP_R7_3200 	.BLKW #1

val				.FILL #2001 ;FILL ME!
;=======================================================================
.orig x3400

ST R7, BACKUP_R7_3400

LD R4, ascii
AND R5, R5, #0

;negative?
ADD R1, R1, #0
BRzp END_NEG_CHECK
;it's negative
LD R0, minus
OUT
NOT R1, R1
ADD R1, R1, #1
END_NEG_CHECK

AND R0, R0, #0
AND R2, R2, #0

DETERMINE_10000
	LD R3, dec_10000

	NOT R3, R3
	ADD R3, R3, #1
	ADD R1, R1, R3

	BRn DETERMINE_10000_PRINT

	ADD R2, R2, #1
	ADD R5, R5, #1

	BR DETERMINE_10000

DETERMINE_10000_PRINT
	LD R3, dec_10000
	ADD R1, R1, R3
	ADD R5, R5, #0

	BRz END_10000_PRINT

	ADD R0, R2, R4
	OUT
END_10000_PRINT

AND R0, R0, #0
AND R2, R2, #0

DETERMINE_1000
	LD R3, dec_1000

	NOT R3, R3
	ADD R3, R3, #1
	ADD R1, R1, R3

	BRn DETERMINE_1000_PRINT

	ADD R2, R2, #1
	ADD R5, R5, #1

	BR DETERMINE_1000

DETERMINE_1000_PRINT
	LD R3, dec_1000

	ADD R1, R1, R3
	ADD R5, R5, #0

	BRz END_1000_PRINT

	ADD R0, R2, R4
	OUT

	END_1000_PRINT

	AND R0, R0, #0
	AND R2, R2, #0

DETERMINE_100
	LD R3, dec_100

	NOT R3, R3
	ADD R3, R3, #1
	ADD R1, R1, R3

	BRn DETERMINE_100_PRINT

	ADD R2, R2, #1
	ADD R5, R5, #1

	BR DETERMINE_100

DETERMINE_100_PRINT
	LD R3, dec_100

	ADD R1, R1, R3
	ADD R5, R5, #0

	BRz END_100_PRINT

	ADD R0, R2, R4
	OUT

END_100_PRINT

AND R0, R0, #0
AND R2, R2, #0

DETERMINE_10
	AND R3, R3, #0
	ADD R3, R3, #-10
	ADD R1, R1, R3

	BRn DETERMINE_10_PRINT

	ADD R2, R2, #1
	ADD R5, R5, #1

	BR DETERMINE_10

DETERMINE_10_PRINT
	AND R3, R3, #0
	ADD R3, R3, #10
	ADD R1, R1, R3
	ADD R5, R5, #0

	BRz END_10_PRINT

	ADD R0, R2, R4
	OUT

	END_10_PRINT

	AND R0, R0, #0

DETERMINE_1
	ADD R0, R1, R4
	OUT
	
	LD R0, newline
	OUT

LD R7, BACKUP_R7_3400

RET
;=======================================================================
BACKUP_R7_3400 .BLKW #1

newline 	.FILL '\n'
minus 		.FILL '-'

dec_10000 	.FILL #10000
dec_1000 	.FILL #1000
dec_100 	.FILL #100
ascii 		.FILL #48
;=======================================================================
.END

