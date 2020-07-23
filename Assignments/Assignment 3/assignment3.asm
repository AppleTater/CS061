;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Jasmine Lau
; Email: 
; 
; Assignment name: Assignment 3
; Lab section: A021
; TA: Jason Goulding
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000				; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
AND R5, R5, #0			;compare R5 and R5
AND R4, R4, #0			;compare R4 and R4

ADD R5, R5, #15			;R5 <- R5 + #15
ADD R4, R4, #4			;R4 <- R4 + #4

LOOPY
	ADD R4, R4, #0		;R4 <- R4 + #0
	BRp NEXT			;if positive, go to NEXT
	
	LEA R0, space		;address of beginning of space
	PUTS				;put space
	
	AND R4, R4, #0		;compare R4 and R4
	ADD R4, R4, #4		;R4 <- R4 + #4
	ADD R5, R5, #0		;R5 <- R5 +#0
	
	BR POST				;branch to END_NEXT
END_LOOPY
		
NEXT
	ADD R1, R1, #0		;R1 <- R1 + #0
	BRn FROOT			;if negative, go to FROOT
	
	LEA R0, zero		;load zero into R0
	PUTS				;'print' R0
	
	BR CONC				;branch to CONC
END_NEXT

FROOT			
	LEA R0, one			;load one into R0
	PUTS				;'print' R0
END_FROOT
	
CONC
	ADD R1, R1, R1		;R1 <- R1 + R1
	ADD R4, R4, #-1		;R4 <- R4 + #-1
	ADD R5, R5, #-1		;R5 <- R5 + #-1
END_CONC

POST
	BRzp LOOPY			;if nonnegative, got to LOOPY
	LEA R0, newline		;load newline into R0
	PUTS				;'print' R0
END_POST

HALT

;---------------	
;Data
;---------------
Value_ptr	.FILL xB4A0	; The address where value to be displayed is stored

one		.STRINGZ "1"
zero		.STRINGZ "0"
space		.STRINGZ " "
newline		.STRINGZ "\n"

.ORIG xB4A0					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
