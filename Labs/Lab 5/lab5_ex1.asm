;=================================================
; Name: Jasmine Lau
; Email: 
; 
; Lab: lab 5, ex 1
; Lab section: A021
; TA: Jason Goulding
; 
;=================================================
.orig x3000

AND R1, R1, #0
ADD R1, R1, #1

LD R2, count
LD R6, ARR_PTR

PAPAYA
	STR R1, R6, #0
	ADD R1, R1, R1
	ADD R6, R6, #1
	ADD R2, R2, #-1
	
	BRp PAPAYA
END_PAPAYA

LD R2, count
LD R5, ARR_PTR
LD R6, SUB_OUTPUT_BINARY_3200_PTR

PINEAPPLE
	JSRR R6
	ADD R5, R5, #1
	ADD R2, R2, #-1
	
	BRp PINEAPPLE
END_PINEAPPLE

HALT

;=======================================================================
count		.FILL #10
ARR_PTR		.FILL x3100

SUB_OUTPUT_BINARY_3200_PTR		.FILL x3200

.orig x3100
ARR .BLKW #10

.orig x3200
ST R0, backup_R0_3200
ST R1, backup_R1_3200
ST R2, backup_R2_3200
ST R3, backup_R3_3200
ST R7, backup_R7_3200

LDR R1, R5, #0
LD R2, count_bits
LD R3, count_spaces

MANGO
	ADD R1, R1, #0
	
	BRn ONE
	
	LD R0, zero
	OUT
	
	BRzp END_ONE
	
	ONE
		LD R0, one
		OUT
	END_ONE
	
	ADD R2, R2, #-1
	BRz END_MANGO
	
	ADD R2, R2, #1
	ADD R3, R3, #-1
	BRz OUT_SPACE
	BRnp END_OUT_SPACE
	OUT_SPACE
		LD R0, space
		OUT
		LD R3,count_spaces
	END_OUT_SPACE
	
	ADD R1, R1, R1
	ADD R2, R2, #-1
	
	BRp MANGO
END_MANGO

LD R0, newline
OUT

LD R0, backup_R0_3200
LD R1, backup_R1_3200
LD R2, backup_R2_3200
LD R3, backup_R3_3200
LD R7, backup_R7_3200

RET

count_spaces	.FILL #4
count_bits		.FILL #16

space			.FILL ' '
newline			.FILL '\n'

zero			.FILL '0'
one				.FILL '1'

backup_R0_3200	.BLKW #1
backup_R1_3200	.BLKW #1
backup_R2_3200	.BLKW #1
backup_R3_3200	.BLKW #1
backup_R7_3200	.BLKW #1

.END
