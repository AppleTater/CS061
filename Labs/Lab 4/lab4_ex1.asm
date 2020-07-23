;=================================================
; Name: Jasmine Lau
; Email: 
; 
; Lab: lab 4, ex 1
; Lab section: A021
; TA: Jason Goulding
; 
;=================================================
.orig x3000

LD R1, zero				;'counter' (hard coded from 0) 
LD R2, array_ptr		;load R2 with memory location of the array
	
LOOPY
	STR R1, R2, #0		
	ADD R2, R2, #1		;R2 <- R2 + #1 (increase pointer)
	ADD R1, R1, #1		;R1 <- R1 + #1 (increment next value to store)
	ADD R3, R1, #-10	;R3 <- R1 + #-10 (check if next is 10)
	BRnp LOOPY			;if not positive, next iteration
	
	LD R4, array_ptr		;load R4 with memory location of array
	ADD R4, R4, #6		;R4 <- R4 + #6 (7th element)
	
	LDR R2, R4, #0		;R2 <- R4 + #0 (load 7th element into R2)
END_LOOPY

HALT

zero		.FILL #0	;hard code first value (0)
array_ptr	.FILL ARRAY	;location of array in memory

.orig x4000
	ARRAY	.BLKW #10	;empty array initializer
	
.END
