;=================================================
; Name: Jasmine Lau
; Email: 
; 
; Lab: lab 3, ex 4
; Lab section: A021
; TA: Jason Goulding
; 
;=================================================
.orig x3000

LD R1, point

DO_WHILE
	GETC
	OUT
	STR R0, R1, #0
	ADD R1, R1, #1
	ADD R0, R0, #-10
	BRnp DO_WHILE
END_DO_WHILE

LD R1, point

DO_WHILE_1
	LDR R0, R1, #0
	OUT
	ADD R2, R0, #0
	;LD R0, newline
	;OUT
	ADD R1, R1, #1
	ADD R2, R2, #-10
	BRnp DO_WHILE_1
END_DO_WHILE_1


HALT

newline .FILL x0A
point	.FILL x4000

.end
