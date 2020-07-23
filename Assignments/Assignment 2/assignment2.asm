;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Jasmine Lau
; Email: jlau053@ucr.edu
; 
; Assignment name: Assignment 2
; Lab section: A021
; TA: Jason Goulding
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------

;1st number
GETC	;TRAP x20: This pauses your program until the user taps a key
OUT		;TRAP x21: This outputs the ASCII code currently stored in R0
ADD R1, R0, #0	;R1 <- R0 + #0
LD R0, NEWLINE
OUT

;2nd number
GETC	;TRAP x20: This pauses your program until the user taps a key
OUT		;TRAP x21: This outputs the ASCII code currently stored in R0
ADD R2, R0, #0	;R2 <- R0 + #0
LD R0, NEWLINE
OUT

;print "1st - 2nd = " 
ADD R0, R1, #0	;R0 <- R1 + #0
OUT		;TRAP x21: This outputs the ASCII code currently stored in R0
LEA R0, minus
PUTS 
ADD R0, R2, #0	;R0 <- R2 + #0
OUT		;TRAP x21: This outputs the ASCII code currently stored in R0
LEA R0, equal
PUTS

;2's Complement, make second number 'negative'
ADD R3, R2, #0	;R3 <- R2 + #0
NOT R3, R3	;complement of bits in R3
ADD R3, R3, #1	;R3 <- R3 + #1

ADD R4, R1, R3	;R4 <- R1 + R3

BRn NEGATIVE	;if negative, go to NEGATIVE
ADD R4, R4, #15		;else: R4 <- R4 + #15
ADD R4, R4, #15		;R4 <- R4 + #15
ADD R4, R4, #15		;R4 <- R4 + #15
ADD R4, R4, #3		;R4 <- R4 + #3

ADD R0, R4, #0		;R4 <- R4 + #0
OUT		;to screen R0
LD R0, NEWLINE
OUT
HALT

NEGATIVE	
	NOT R4, R4			;complement of bits in R4
	ADD R4, R4, #1		;R4 <- R4 + #1
	ADD R4, R4, #15		;R4 <- R4 + #15			
	ADD R4, R4, #15		;R4 <- R4 + #15
	ADD R4, R4, #15		;R4 <- R4 + #15
	ADD R4, R4, #3		;R4 <- R4 + #3
	
	LEA R0, negative
	PUTS
	ADD R0, R4, #0		;R0 <- R4 + #0
	OUT
	LD R0, NEWLINE
	OUT
END_NEGATIVE
	HALT

;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
NEWLINE .FILL '\n'	; newline character - use with LD followed by OUT
negative .STRINGZ "-"
minus .STRINGZ " - "
equal .STRINGZ " = "

;---------------	
;END of PROGRAM
;---------------	
.END
