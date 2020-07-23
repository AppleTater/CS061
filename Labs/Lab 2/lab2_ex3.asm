;=================================================
; Name: Jasmine Lau
; Email:  jlau053@ucr.edu
; 
; Lab: lab 2, ex 3
; Lab section: A21
; TA: Jasone Goulding 
; 
;=================================================
.orig x3000

	LD R5, DEC_65_PTR	;R5 <-- pointer to remote data
	LD R6, HEX_41_PTR	;R6 <-- pointer to remote data
	
	LDR R3, R5, #0	;copies value from R3 + offset 0 into R5
	LDR R4, R6, #0	;copies value from R4 + offset 0 into R6
	
	ADD R3, R3, #1	;R3 <-- R3 + #1
	ADD R4, R4, #1	;R4 <-- R4 + #1
	
	STR R3, R5, #0	;copies value stored in R3 into the address stored
					;in R5	
	STR R4, R6, #0	;copies value stored in R4 into the address stored
					;in R6
	
	HALT
	
	DEC_65_PTR	.FILL x4000
	HEX_41_PTR	.FILL x4001
	
	;; Remote data
		.orig x4000	;next line is at memory location x4000
	.FILL #65	;Fill remote memory with #65, at x4000
	.FILL x41	;Fill remote memory with x41, at x4001
	
	
.END
