;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Jasmine Lau
; Email: jlau053@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: A021
; TA: Jason Goulding 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R3
;=================================================================================
 
.orig x3000		
;-------------
;Instructions
;-------------

BEGIN
; output intro prompt
	LEA R0, prompt		;print prompt
	PUTS				;TRAP x22
						
; Set up flags, counters, accumulators as needed
	LD R6, counter		;max 6 characters (+1 for preceding sign)
	AND R3, R3, #0		;total
END_BEGIN

LEMON
	GETC				;NO ghost writing
	
	ADD R1, R0, #0		;R1 <- R0 + #0 
	LD R2, newline		;load newline into R2
	ADD R1, R1, R2		;R1 <- R1 + R2
	
	BRnp ORANGE			;if not equal, go to ORANGE
END_LEMON
	
POMMELO
	ADD R1, R0, #0		;R1 <- R0 + #0
	LD R2, sub48		;load R7 with sub48		
	ADD R1, R1, R2		;R1 <- R1 + R2
	
	BRn LESS_THAN		;if less than 0, go to LESS_THAN
	
	ADD R1, R0, #0		;R1 <- R0 + #0
	LD R2, sub57		;load R2 with sub57
	ADD R1, R1, R2		;R1 <- R1 + R2
	
	BRp GREATER_THAN	;if greater than 0, go to GREATER_THAN

	ADD R1, R6, #0		;R1 <- R6 + #0
	ADD R1, R1, #-6		;R1 <- R6 + #-6
	
	BRz FIRST_NUM		;if equal to 0, go to FIRST_NUM

	ADD R3, R3, R3		;R3 <- R3 + R3
	ADD R2, R3, R3		;R2 <- R3 + R3
	ADD R2, R2, R2		;R2 <- R2 + R2
	ADD R3, R3, R2		;R3 <- R3 + R2
	LD R2, sub48		;load R2 with sub48
	ADD R0, R0, R2		;R0 <- R0 + R2
	ADD R3, R3, R0		;R3 <- R3 + R0
	ADD R6, R6, #-1		;R6 <- R6 + #-1
	
	BRp LEMON			;if greater than 0, go to LEMON
	
	BRz EGG				;if equal to 0, go to EGG
END_POMMELO

ORANGE
	OUT					;TRAP x21, GETC in POMMELO
	
	BRnzp POMMELO		;break and go to POMMELO
END_ORANGE
	
OUT_ERROR
	LD R0, newlineCH	;load what is stored in 'newlineCH' to R0
	OUT 				;TRAP x21
	
	BRnzp WRONG			;break and go to WRONG
END_OUT_ERROR

;Get first character, test for '\n', '+', '-', digit/non-digit 	
FIRST_CHAR
	NOT R3, R3			;1's Complement
	ADD R3, R3, #1		;2's Complement
	
	BRnzp RAMBUTAN		;break and go to RAMBUTAN
END_FIRST_CHAR

;if none of the above, first character is first numeric digit - convert it to number & store in target register!
FIRST_NUM
	LD R2, sub48		;load what is stored in 'sub48' to R2
		
	ADD R0, R0, R2		;R0 <- R0 + R2
	ADD R3, R0, R3		;R3 <- R0 + R3
	ADD R6, R6, #-2		;no sign
	
	BRnzp LEMON			;break and go to LEMON
END_FIRST_NUM
	
;is very first character = '\n'? if so, just quit (no message)!	
FIRST_NEW
	ADD R1, R6, #0		;R1 <- R6 + #0
	ADD R1, R1, #-6		;its quittin' time
	
	BRz RAMBUTAN		;if equal to 0, go to RAMBUTAN
	
	ADD R1, R6, #0		;R1 <- R6 + #0
	ADD R1, R1, #-5		;R1 <- R1 + #-5
	
	BRnp EGG			;if not equal to 0, go to EGG
	
	ADD R1, R5, #0		;R1 <- R5 + #0
	ADD R1, R1, #-1		;R1 <- R1 + #-1
	
	BRz OUT_ERROR		;if equal to 0, go to OUT_ERROR
	BRnp EGG			;if not equal to 0, go to EGG
END_FIRST_NEW
	
;is it = '+'? if so, ignore it, go get digits
FIRST_PLUS
	ADD R1, R6, #0		;R1 <- R6 + #0
	ADD R1, R1, #-6		;it's quittin time
	
	BRnp GREATER_THAN	;if not equal to 0, go to GREATER_THAN
		
	ADD R4, R4, #0		;R4 <- R4 + #0
	ADD R5, R5, #1		;R5 <- R5 + #1
	ADD R6, R6, #-1		;R6 <- R6 + #-1
	
	BRnzp LEMON			;break and go to LEMON
END_FIRST_PLUS
	
;is it = '-'? if so, set neg flag, go get digits
FIRST_MINUS
	ADD R1, R6, #0		;R1 <- R6 + #0
	ADD R1, R1, #-6		;it's quittin time
	
	BRnp GREATER_THAN	;if not equal 0, go to GREATER_THAN
		
	ADD R4, R4, #1		;R4 <- R4 + #1
	ADD R5, R5, #1		;R5 <- R5 + #1
	ADD R6, R6, #-1		;R6 <- R6 + #-1
	
	BRnzp LEMON			;break and go to LEMON
END_FIRST_MINUS

;is it < '0'? if so, it is not a digit	- o/p error message, start over	
LESS_THAN
	LD R2, positve		;load what is stored in 'postive' into R2
	ADD R1, R0, #0		;R1 <- R0 + #0
	ADD R1, R1, R2		;R1 <- R1 + R2
	
	BRz FIRST_PLUS		;if equal to 0, go to FIRST_PLUS
	
	LD R2, negative		;load what is stored in 'negative' into R2
	ADD R1, R0, #0		;R1 <- R0 + #0
	ADD R1, R1, R2		;R1 <- R1 + R2
	
	BRz FIRST_MINUS		;if equal to 0, go to FIRST_MINUS
	
	LD R2, newline		;load what is stored in 'newline' into R7
	ADD R1, R0, #0		;R1 <- R0 + #0
	ADD R1, R1, R2		;R1 <- R1 + R2
	
	BRz FIRST_NEW		;if equal to 0, go to FIRST_NEW
END_LESS_THAN
	
;is it > '9'? if so, it is not a digit	- o/p error message, start over	
GREATER_THAN
	ADD R1, R0, #0		;R1 <- R0 + #0
	ADD R1, R1, #-10	;R1 <- R1 + #-10
	
	BRnp OUT_ERROR		;if not equal to 0, go to OUT_ERROR
END_GREATER_THAN

WRONG
	LEA R0, badMessage	;load address of 'badMessage' into R0
	PUTS				;TRAP x22
	
	BRnzp BEGIN			;break and go to BEGIN
END_WRONG
	
EGG
	ADD R1, R4, #0		;R1 <- R4 + #0 (copy R4 in to R1, currently the sign)
	ADD R1, R1, #-1		;R1 <- R1 + #-1
	
	BRz FIRST_CHAR		;if equal to 0, go to NEG
END_EGG

RAMBUTAN
	LD R0, newlineCH 	;remember to end with a newline!
	OUT					;TRAP x21
END_RAMBUTAN
					
HALT					;TRAP x25

;Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, and build up number in accumulator

;---------------	
; Program Data
;---------------
counter		.FILL #6 	;+1 for preceding sign
newlineCH	.FILL #10	;fill with 10	

newline		.FILL #-10	;fill with -10
positve		.FILL #-43	;fill with -43
negative 	.FILL #-45	;fill with -45
sub48		.FILL #-48	;fill with -48
sub57		.FILL #-57	;fill with -57
;introPromptPtr	.FILL xB000
;errorMessagePtr.FILL xB200

;------------
; Remote data
;------------
;.orig xB000			;intro prompt
prompt		.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
;.orig  xB200			;error message
badMessage	.STRINGZ	"ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
.end

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
