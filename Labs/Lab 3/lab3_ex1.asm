;=================================================
; Name: Jasmine Lau
; Email:
; 
; Lab: lab 3, ex 1
; Lab section: A021
; TA: Jason Goulding
; 
;=================================================
.orig x3000

	LD R5, DATA_PTR	;R5 <-- pointer to remote data
	
	ADD R6, R5, #1	;R6 <- R5 + #1
	
	LDR R3, R5, #0	;copies value from R3 + offset 0 into R5
	LDR R4, R6, #0	;copies value from R4 + offset 0 into R6
	
	ADD R3, R3, #1	;R3 <-- R3 + #1
	ADD R4, R4, #1	;R4 <-- R4 + #1
	
	STR R3, R5, #0	;copies value stored in R3 into the address stored
					;in R5	
	STR R4, R6, #0	;copies value stored in R4 into the address stored
					;in R6
	
	HALT
	
	DATA_PTR	.FILL	x4000
	;; Remote data
		.orig x4000	;next line is at memory location x4000
	.FILL	#65
	.FILL 	x41
	
	
.END
