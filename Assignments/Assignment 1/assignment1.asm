;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Lau, Jasmine
; Email: 
; 
; Assignment name: Assignment 1
; Lab section: A021
; TA: Jason Goulding
;
;=========================================================================

;-------------------------------------------------------------------------
;           BUILD TABLE HERE
;-------------------------------------------------------------------------
; REG VALUES       R0    R1      R2    R3   R4   R5   R6   R7
;-------------------------------------------------------------------------
; Pre-loop          0    6       12     0    0    0    0    1168
; Iteration 02      0    5       12    12    0    0    0    1168 
; Iteration 03      0    4       12    24    0    0    0    1168                  
; Iteration 04      0    3       12    36    0    0    0    1168
; Iteration 05      0	 2       12    48    0    0    0    1168
; Iteration 06      0    1       12    60    0    0    0    1168
; Iteration 07      0	 0       12    72    0    0    0    DEC_0     
; End of program    0    0       12    72    0    0    0    DEC_0
;-------------------------------------------------------------------------
;

				.ORIG x3000			; Program begins here
;-------------
;Instructions: CODE GOES HERE
;-------------
	LD R1, DEC_6
	LD R2, DEC_12
	AND R3, R3, x0
	
	DO_WHILE ADD R3, R3,R2
             ADD R1, R1, #-1
             BRP DO_WHILE
			
HALT

;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------
DEC_0	.FILL	#0
DEC_6	.FILL	#6
DEC_12	.FILL	#12

;---------------	
;END of PROGRAM
;---------------	
.END


