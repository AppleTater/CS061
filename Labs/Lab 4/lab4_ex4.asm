;=================================================
; Name: Jasmine Lau
; Email: jlau053@ucr.edu
; 
; Lab: lab 4, ex 4
; Lab section: A021
; TA: Jasone Goulding
; 
;=================================================
.orig x3000

LD R1, one				;'counter' (hard coded from 1) 
LD R2, array_ptr		;load R2 with memory location of the array
LD R5, huge				;load maximum value
	
LOOPY
	STR R1, R2, #0		
	ADD R2, R2, #1		;R2 <- R2 + #1 (increase pointer)
	ADD R1, R1, R1		;R1 <- R1 + #1 (increment next value to store)
	ADD R3, R1, R5		;R3 <- R1 + R5 (check if next is 2^9)
	BRnp LOOPY			;if not, next iteration
	
	LD R4, array_ptr	;load R4 with memory location of array
	ADD R4, R4, #6		;R4 <- R4 + #6 (7th element)
	
	LDR R2, R4, #0		;R2 <- R4 + #0 (load 7th element into R2)
END_LOOPY

LD R2, array_ptr		;'counter' (hard coded from 1)
LD R3, count			;load maximum value
OUTPUT
	LDR R0, R2, #0		;memory location of array pointer to R0
	ADD R0, R0, #0		;R3 <- R0 + #0 (memory location to R3)
	OUT
	
	ADD R2, R2, #1		;R1 <- R1 + #1 
	ADD R3, R3, #-1 	;R3 <- R3 + #-9
	BRnp OUTPUT			;if not positive, next iteration
END_OUTPUT

HALT

one			.FILL x1	;hard code first value (2^0)
array_ptr	.FILL ARRAY	;location of array in memory
huge		.FILL #-1024;,maximum value (2^10)
count		.FILL #10
newline		.FILL #10

.orig x4000
	ARRAY	.BLKW #10	;empty array initializer
	
.END
