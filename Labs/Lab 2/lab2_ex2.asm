;=================================================
; Name: Jasmine Lau
; Email: jlau053@ucr.edu
; 
; Lab: lab 2. ex 2
; Lab section: A21
; TA: Jason Goulding
; 
;=================================================
.orig x3000

	LDI R3, DEC_65_PTR	;R3 <-- pointer to remote data
	LDI R4, HEX_41_PTR	;R4 <-- pointer to remote data
	
	ADD R3, R3, #1	;R3 <-- R3 + #1
	ADD R4, R4, #1	;R4 <-- R4 + #1
	
	STI R3, DEC_65_PTR	;store pointer in inremented R3
	STI R4, HEX_41_PTR	;store pointer in incremented R4
	
	HALT
	
	DEC_65_PTR	.FILL x4000	
	HEX_41_PTR	.FILL x4001
	
	;; Remote data
		.orig x4000	;next line is at memory location x4000
	.FILL #65	;Fill remote memory with #65, at x4000
	.FILL x41	;Fill remote memory with x41, at x4001
	
	
.END
