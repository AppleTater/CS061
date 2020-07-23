;=================================================
; Name: Jasmine Lau
; Email: 
; 
; Lab: lab 9, ex 1 & 2
; Lab section: A021
; TA: Jason Goulding
; 
;=================================================

; test harness
.orig x3000
LD R4, base_ptr
LD R5, max_ptr
LD R6, base_ptr
  
PUSH_LOOP
  LEA R0,push_prompt
  PUTS
  
  AND R0, R0, #0
  GETC
  OUT

  LD R2, zero
  ADD R0, R0, R2

  LD R1, SUB_STACK_PUSH_ADDY
  JSRR  R1
  
  ADD R3, R3, #0
  BRnz PUSH_LOOP
  BRp POP_LOOP

POP_LOOP
  LEA R0, pop_prompt
  PUTS
  
  LD R1,SUB_STACK_POP_ADDY
  JSRR R1
  
  ADD R3, R3, #0 
  BRnz POP_LOOP
  BRp END_POP
  
  END_POP
	halt

;-----------------------------------------------------------------------------------------------
; test harness local data:
zero				.FILL #-48

push_prompt			.STRINGZ "ENTER VALUE TO PUSH\n"
pop_prompt			.STRINGZ "ENTER VALUE TO POP\n"

base_ptr			.FILL x4000
max_ptr				.FILL x4005

SUB_STACK_PUSH_ADDY	.FILL x3200
SUB_STACK_POP_ADDY 	.FILL x3400
;===============================================================================================
halt

; subroutines:

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------
.orig x3200
				 
ST R1, BACKUP_R1_x3200
ST R2, BACKUP_R2_x3200
ST R7, BACKUP_R7_x3200

AND R3, R3, #0
AND R1, R1, #0

ADD R1, R1, R6
NOT R1, R1

ADD R1, R1, #1
ADD R1, R1, R5

AGENT
  BRz PERRY
  DOOFENSHMIRTZ
    ADD R6, R6, #1
    
    STR R0, R6, #0
    LEA R0,	newline
    PUTS
    
    BR MONOGRAM
  PERRY
    ADD R3, R3, #1
    
    LEA R0, push_overflow
    PUTS
  MONOGRAM
LD R1, BACKUP_R1_x3200
LD R2, BACKUP_R2_x3200
LD R7, BACKUP_R7_x3200

RET
;-----------------------------------------------------------------------------------------------
; SUB_STACK_PUSH local data
BACKUP_R1_x3200 	.BLKW #1
BACKUP_R2_x3200 	.BLKW #1
BACKUP_R7_x3200 	.BLKW #1

newline				.STRINGZ "\n"

push_overflow		.STRINGZ "\nOVERFLOWING STACK.\n"
;===============================================================================================


;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available                      
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Value: R0 ← value popped off the stack
;		   R6 ← updated TOS
;------------------------------------------------------------------------------------------
.orig x3400

ST R1, BACKUP_R1_x3400
ST R2, BACKUP_R2_x3400
ST R7, BACKUP_R7_x3400

AND R3, R3, #0
AND R1, R1, #0
AND R0, R0, #0

ADD R1, R1, R6 
NOT R1, R1

ADD R1, R1, #1
ADD R1, R1, R4

BERRY
  BRz BIRT
  WHISTLE
    LDR R0, R6, #0
    LD R2, thirty
    
    ADD R0, R0, R2
    OUT
    
    ADD R6, R6, #-1
    LEA R0, newliner
    PUTS
    
    BR GIEDROYC
  BIRT
    ADD R3, R3, #1
    
    LEA R0, pop_underflow
    PUTS
  GIEDROYC
 
LD R1, BACKUP_R1_x3400
LD R2, BACKUP_R2_x3400
LD R7, BACKUP_R7_x3400

RET

POPUNDERFLOW .STRINGZ "\nStack is underflowing.\n"
;-----------------------------------------------------------------------------------------------
; SUB_STACK_POP local data

BACKUP_R1_x3400 .BLKW #1
BACKUP_R2_x3400 .BLKW #1
BACKUP_R7_x3400 .BLKW #1

newliner 			.STRINGZ "\n"

pop_underflow		.STRINGZ "\UNDERFLOWING STACK.\n"

thirty				.FILL x0030
;===============================================================================================
