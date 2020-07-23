;=================================================
; Name: Jasmine Lau
; Email: 
; 
; Lab: lab 9, ex 1 & 2
; Lab section: A021
; TA: Jason Goulding
; 
;=================================================

.orig x3000

LD R2, NEWLINE

NOT R2, R2
ADD R2, R2, #1
  
LD R4, BASE
LD R5, MAX
LD R6, TOS

WHILE_LOOP
  LEA R0, PROMPT_1
  PUTS

  GETC
  OUT

  LD R1, OFFSET
  ADD R3, R0, R1
  BRz POP_STACK

  LEA R0, PROMPT_2
  PUTS

  GETC
  OUT

  ADD R3, R0, R2
  BRz END_LOOP

  ST R0, USER_INPUT
  LD R0, NEWLINE

  OUT
  LD R0, USER_INPUT
  LD R1, OFFSET

  ADD R0, R0, R1
  LD R1, SUB_STACK_PUSH

  JSRR R1
  BRnzp WHILE_LOOP

POP_STACK
  LD R0, NEWLINE
  OUT

  AND R0, R0, #0 
  LD R1, SUB_STACK_POP

  JSRR R1
  LD R1, OFFSET

  NOT R1, R1
  ADD R1, R1, #1
  ADD R0, R0, R1

  BRn WHILE_LOOP
  NOT R1, R0
  ADD R1, R1, #1

  LD R2, NUM_MAX
  ADD R2, R2, R1
  BRn WHILE_LOOP
  OUT

  LEA R0, PROMPT_3
  PUTS

  BRnzp WHILE_LOOP

END_LOOP
  HALT

;Local Data

SUB_STACK_PUSH 	.FILL x3200
SUB_STACK_POP 	.FILL x3400

OFFSET   		.FILL #-48
NUM_MAX  	 	.FILL x39
NEWLINE  		.FILL x0A

BASE 	 		.FILL xA000
MAX 			.FILL xA005
TOS 			.FILL xA000

PROMPT_1 		.STRINGZ "Pop (0) or Push (1)\n"
PROMPT_2 		.STRINGZ "\nWhat value would you like to push?\n"
PROMPT_3 		.STRINGZ " was the value popped\n"

USER_INPUT 		.BLKW 1


;------------------------------------------------------------------------------------------
;Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
; address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1).
;  If the stack was already full (TOS = MAX), the subroutine has printed an
;  overflow error message and terminated.
; Return Value: R6  updated TOS
;------------------------------------------------------------------------------------------
.orig x3200
;Subroutine Instructions

ST R2, BACKUP_R2
ST R7, BACKUP_R7

NOT R2, R5
ADD R2, R2, #1

ADD R2, R6, R2
BRzp OVERFLOW_ERROR

ADD R6, R6, #1
STR R0, R6, #0

LD R2, BACKUP_R2
LD R7, BACKUP_R7

RET

OVERFLOW_ERROR
  ST R0, R0_ERROR
  LEA R0, OVERFLOW_MESSAGE
  PUTS

  LD R0, R0_ERROR
  LD R2, BACKUP_R2
  LD R7, BACKUP_R7

  RET

;Subroutine Data
OVERFLOW_MESSAGE .STRINGZ "Error Overflow!!\n"

R0_ERROR 		 .BLKW 1
BACKUP_R2 		 .BLKW 1
BACKUP_R7 		 .BLKW 1


;------------------------------------------------------------------------------------------
;Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
; address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[top] off of the stack.
;  If the stack was already empty (TOS = BASE), the subroutine has printed
;  an underflow error message and terminated.
; Return Value: R0  value popped off of the stack
;  R6  updated TOS
;------------------------------------------------------------------------------------------
.orig x3400
;Subroutine Instructions

ST R2, BACKUP_R2_2
ST R7, BACKUP_R7_2

NOT R2, R4
ADD R2, R2, #1

ADD R2, R6, R2
BRnz ERROR

LDR R0, R6, #0
ADD R6, R6, #-1

LD R2, BACKUP_R2_2
LD R7, BACKUP_R7_2

RET

ERROR
  LEA R0, UNDERFLOW_MESSAGE
  PUTS

  LD R2, BACKUP_R2_2
  LD R7, BACKUP_R7_2
  
  RET

;Subroutine Data
UNDERFLOW_MESSAGE.STRINGZ "Error Underflow!!\n"

BACKUP_R2_2		 .BLKW 1
BACKUP_R7_2		 .BLKW 1


