;=================================================
; Name: Jasmine Lau
; Email: 
; 
; Lab: lab 2. ex 1
; Lab section: A21
; TA: Jason Goulding
; 
;=================================================
.orig x3000

	LD R3, DEC_65	;R3 <-- #65
	LD R4, HEX_41	;R4 <-- x41
	
	DEC_65	.FILL #65	;Fills a memory location with #65
	HEX_41	.FILL x41	;Fills a memory location with x41
	
.END
