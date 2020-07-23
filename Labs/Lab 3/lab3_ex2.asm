;=================================================
; Name: Jasmine Lau
; Email: 
; 
; Lab: lab 3, ex 2
; Lab section: A021
; TA: Jason Goulding
; 
;=================================================
.orig x3000

LEA R0, enter
PUTS

LD R1, counter
LEA R2, ARRAY_1

DO_WHILE
	GETC
	STR R0, R2, #0
	ADD R2, R2, #1
	OUT
	ADD R1, R1, #-1

END_DO_WHILE
	
BRp DO_WHILE

HALT

enter	.STRINGZ "Enter 10 charcters: "
counter	.FILL #10
ARRAY_1	.BLKW #10
.end
