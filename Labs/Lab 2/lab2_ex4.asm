;=================================================
; Name: Jasmine Lau
; Email:
; 
; Lab: lab 2, ex 4
; Lab section: A21
; TA: Jason Goulding
; 
;=================================================
.orig x3000
	
	LD R0, HEX_61	;R0 <-- x61
	LD R1, HEX_1A	;R1 <-- x1A
		
	BRp LOOP
	
	HALT 
	
	LOOP	
		OUT	;print R0 to the screen as ASCII character
		
		ADD R0, R0, #1	;R0 <-- R0 + #1
		ADD R1, R1, #-1	;R1 <-- R1 + #-1

		BRp LOOP
	END_LOOP
		
	HALT
		
	HEX_61	.FILL x61
	HEX_1A	.FILL x1A
	
	;; Remote data
		.orig x4000
	.FILL #65
	.FILL x41
		
.END
	
