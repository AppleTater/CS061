;=================================================
; Name: Jasmine Lau
; Email: 
; 
; Lab: lab 3, ex 3
; Lab section: A021
; TA: Jason Goulding
; 
;=================================================
.orig x3000

LEA R0, enter
PUTS

LEA R2, ARRAY_1
LD R1, counter

DO_WHILE
	GETC
	OUT
	STR R0, R2, #0
	ADD R2, R2, #1
	;OUT
	ADD R1, R1, #-1
	BRp DO_WHILE
END_DO_WHILE

LEA R3, ARRAY_1
LD R1, counter

DO_WHILE_1
	LDR R0, R3, #1
	OUT
	LD R0, newline
	OUT
	ADD R3, R3, #1
	ADD R1, R1, #-1
	BRp DO_WHILE_1
END_DO_WHILE_1

HALT

enter	.STRINGZ "Enter 10 charcters: "
counter	.FILL #10
ARRAY_1	.BLKW #10
newline .STRINGZ "\n"
.end
