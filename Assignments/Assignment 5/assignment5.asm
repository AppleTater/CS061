;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Jasmine Lau
; Email: 
; 
; Assignment name: Assignment 5
; Lab section: A021
; TA: Jason Goulding
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================
;-------------
;Instructions
;-------------
.orig x3000
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
MAIN_LOOPY
;user choice in R1
	LD R6, menu_addy
	JSRR R6
	
	ADD R1, R1, #-1
	BRz CHOSEN_ONE
	
	ADD R1, R1, #-1
	BRz CHOSEN_TWO
	
	ADD R1, R1, #-1
	BRz CHOSEN_THREE
	
	ADD R1, R1, #-1
	BRz CHOSEN_FOUR
	
	ADD R1, R1, #-1
	BRz CHOSEN_FIVE
	
	ADD R1, R1, #-1
	BRz CHOSEN_SIX
	
	ADD R1, R1, #-1
	BRz STOP
END_MAIN_LOOPY


CHOSEN_ONE
	LD R6, all_busy_addy
	JSRR R6

	ADD R2, R2, #0
	BRp ALL_BUSY
	BR NOT_ALL_BUSY
	
	ALL_BUSY
		LEA R0, allbusy
		PUTS
		
		BR MAIN_LOOPY
		NOT_ALL_BUSY
		
		LEA R0, allnotbusy
		PUTS
		
		BR MAIN_LOOPY

CHOSEN_TWO
	LD R6, all_free_addy
	JSRR R6
	
	ADD R2, R2, #0
	BRp ALL_FREE
	BR NOT_ALL_FREE
	
	ALL_FREE
		LEA R0, allfree
		PUTS
	
		BR MAIN_LOOPY
		NOT_ALL_FREE
	
		LEA R0, allnotfree
		PUTS
	
		BR MAIN_LOOPY

CHOSEN_THREE
	LD R6, num_busy_addy
	JSRR R6
	
	LEA R0, busymachine1
	PUTS
	
	LD R6, print_num_addy
	JSRR R6
	
	LEA R0, busymachine2
	PUTS
	
	BR MAIN_LOOPY

CHOSEN_FOUR
	LD R6, num_free_addy
	JSRR R6
	
	LEA R0, freemachine1
	PUTS	
	
	LD R6, print_num_addy
	JSRR R6
	
	LEA R0, freemachine2
	PUTS
	
	BR MAIN_LOOPY

CHOSEN_FIVE
	LD R6, get_num_addy
	JSRR R6
	
	LEA R0, status1
	PUTS
	
	LD R6, print_num_addy
	JSRR R6
	
	LD R6, machine_stat_addy
	JSRR R6
	
	ADD R2, R2, #0
	BRz IS_BUSY
	BR NOT_BUSY

	IS_BUSY
		LEA R0, status2
		PUTS
		BR MAIN_LOOPY
	
	NOT_BUSY
		LEA R0, status3
		PUTS
		BR MAIN_LOOPY

CHOSEN_SIX
	LD R6, first_addy
	JSRR R6
	
	ADD R1, R1, #0
	BRn NONE_FREE
	BR IS_FREE_MACH
	
	NONE_FREE
		LEA R0, firstfree2
		PUTS
		
		BR MAIN_LOOPY
	
	IS_FREE_MACH
		LEA R0, firstfree1
		PUTS
		
		LD R6, print_num_addy
		JSRR R6
		
		LD R0, newline
		OUT
		
		BR MAIN_LOOPY

STOP	
	LEA R0, goodbye
	PUTS
	
	HALT


;---------------	
;Data
;---------------
;Subroutine pointers
menu_addy			.FILL x3200
all_busy_addy		.FILL x3400
all_free_addy		.FILL x3600
num_busy_addy 		.FILL x3800
num_free_addy 		.FILL x4000
machine_stat_addy 	.FILL x4200
first_addy 			.FILL x4400
get_num_addy 		.FILL x4600
print_num_addy 		.FILL x4800


;Other data 
newline 		.fill '\n'

; Strings for reports from menu subroutines:
goodbye         .stringz "Goodbye!\n"
allbusy         .stringz "All machines are busy\n"
allnotbusy      .stringz "Not all machines are busy\n"
allfree         .stringz "All machines are free\n"
allnotfree		.stringz "Not all machines are free\n"
busymachine1    .stringz "There are "
busymachine2    .stringz " busy machines\n"
freemachine1    .stringz "There are "
freemachine2    .stringz " free machines\n"
status1         .stringz "Machine "
status2		    .stringz " is busy\n"
status3		    .stringz " is free\n"
firstfree1      .stringz "The first available machine is number "
firstfree2      .stringz "No machines are free\n"
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;-------------------------------
.ORIG x3200
;HINT back up 
ST R0, backup_R0_3200 
ST R2, backup_R2_3200 
ST R3, backup_R3_3200 
ST R7, backup_R7_3200 

MENU
	LD R0, Menu_string_addr
	PUTS
	
	GETC
	OUT
	
	ADD R2, R0, #0
	LD R3, ASSCII
	
	ADD R1, R2, R3
	
	BRnz DISGUSTING
	ADD R1, R1, #-8
	BRzp DISGUSTING
	
	ADD R1, R1, #8
	BR AFTER
	
DISGUSTING
	LD R0, NEWLINER
	OUT
	
	LEA R0, Error_msg_1
	PUTS
	BR MENU
AFTER
	LD R0, NEWLINER
	
OUT
;HINT Restore
	LD R0, backup_R0_3200 
	LD R2, backup_R2_3200 
	LD R3, backup_R3_3200 
    LD R7, backup_R7_3200 
RET
;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_msg_1	      .STRINGZ "INVALID INPUT\n"
Menu_string_addr  .FILL x5000

NEWLINER .FILL '\n'
ASSCII .FILL #-48

backup_R0_3200 .BLKW #1
backup_R2_3200 .BLKW #1
backup_R3_3200 .BLKW #1
backup_R7_3200 .BLKW #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
.orig x3400
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;-------------------------------
;HINT back up
ST R0, backup_R0_3400 
ST R1, backup_R1_3400 
ST R2, backup_R2_3400 
ST R3, backup_R3_3400
ST R4, backup_R4_3400 
ST R5, backup_R5_3400 
ST R6, backup_R6_3400  
ST R7, backup_R7_3400

AND R2, R2, #0
LDI R1, BUSYNESS_ADDR_ALL_MACHINES_BUSY
LD R3, EUGH
AND R1, R1, R3
BRz FROGGY
BR CHAIR

FROGGY
	ADD R2, R2, #1
	
CHAIR
;HINT Restore
	LD R0, backup_R0_3400 
	LD R1, backup_R1_3400 
	LD R2, backup_R2_3400 
	LD R3, backup_R3_3400
	LD R4, backup_R4_3400 
	LD R5, backup_R5_3400 
	LD R6, backup_R6_3400  
	LD R7, backup_R7_3400 
	
	RET
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xAA00
EUGH 							.Fill xFFFF
	
backup_R0_3400 					.BLKW #1
backup_R1_3400 					.BLKW #1
backup_R2_3400 					.BLKW #1
backup_R3_3400					.BLKW #1
backup_R4_3400 					.BLKW #1
backup_R5_3400 					.BLKW #1
backup_R6_3400  				.BLKW #1
backup_R7_3400 					.BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
.orig x3600
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;-------------------------------
;HINT back up 
ST R0, backup_R0_3600
ST R1, backup_R1_3600
ST R2, backup_R2_3600
ST R3, backup_R3_3600
ST R4, backup_R4_3600
ST R5, backup_R5_3600
ST R6, backup_R6_3600
ST R7, backup_R7_3600

AND R2, R2, #0

LDI R1, BUSYNESS_ADDR_ALL_MACHINES_FREE
LD R3, AUGH

AND R1, R1, R3
ADD R1, R1, #1

BRz FAUNA
BR FLORA

FAUNA
	ADD R2, R2, #1

FLORA
;HINT Restore
	LD R0, backup_R0_3600
	LD R1, backup_R1_3600
	LD R2, backup_R2_3600
	LD R3, backup_R3_3600
	LD R4, backup_R4_3600
	LD R5, backup_R5_3600
	LD R6, backup_R6_3600
	LD R7, backup_R7_3600

	RET
;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xAA00
AUGH 							.FILL xFFFF

backup_R0_3600 					.BLKW #1
backup_R1_3600 					.BLKW #1
backup_R2_3600 					.BLKW #1
backup_R3_3600 					.BLKW #1
backup_R4_3600 					.BLKW #1
backup_R5_3600 					.BLKW #1
backup_R6_3600					.BLKW #1
backup_R7_3600 					.BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R1): The number of machines that are busy (0)
;-----------------------------------------------------------------------------------------------------------------
.orig x3800
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------

;HINT back up 
ST R2, backup_R2_3800 
ST R3, backup_R3_3800 
ST R7, backup_R7_3800

AND R1, R1, #0
LDI R2, BUSYNESS_ADDR_NUM_BUSY_MACHINES

AND R3, R3, #0
ADD R3, R3, #15
ADD R3, R3, #1

BLUE
	ADD R2, R2, #0
	BRzp FOOTED
	BR BOBIE
	
FOOTED
	ADD R1, R1, #1
	
BOBIE
	ADD R2, R2, R2
	ADD R3, R3, #-1
	BRp BLUE

;HINT Restore
	LD R2, backup_R2_3800 
	LD R3, backup_R3_3800 
	LD R7, backup_R7_3800 
	RET
;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xAA00
backup_R2_3800 .BLKW #1
backup_R3_3800 .BLKW #1
backup_R7_3800 .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R1): The number of machines that are free (1)
;-----------------------------------------------------------------------------------------------------------------
.orig x4000
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
;HINT back up 
ST R2, backup_R2_4000 
ST R3, backup_R3_4000 
ST R7, backup_R7_4000 

AND R1, R1, #0
LDI R2, BUSYNESS_ADDR_NUM_FREE_MACHINES

AND R3, R3, #0
ADD R3, R3, #15
ADD R3, R3, #1

WATER
	ADD R2, R2, #0
	BRn MELON
	BR SUGAR

MELON
	ADD R1, R1, #1
SUGAR
	ADD R2, R2, R2
	ADD R3, R3, #-1

	BRp WATER
;HINT Restore
	LD R2, backup_R2_4000 
	LD R3, backup_R3_4000 
	LD R7, backup_R7_4000 
	RET
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES 
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xAA00

backup_R2_4000 .BLKW #1
backup_R3_4000 .BLKW #1
backup_R7_4000 .BLKW #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;-----------------------------------------------------------------------------------------------------------------
.orig x4200
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;-------------------------------
;HINT back up 
ST R1, backup_R1_4200
ST R3, backup_R3_4200
ST R4, backup_R4_4200
ST R5, backup_R5_4200
ST R7, backup_R7_4200

AND R2, R2, #0
LDI R3, BUSYNESS_ADDR_MACHINE_STATUS
ADD R1, R1, #-15

BRz JUPITER

SATURN
	ADD R3, R3, R3
	ADD R1, R1, #1
	BRz JUPITER
	BR SATURN

JUPITER
	ADD R3, R3, #0
	BRn GRASS
	BR MAPLE
	
GRASS
	ADD R2, R2, #1
	
MAPLE
;HINT Restore
	LD R1, backup_R1_4200
	LD R3, backup_R3_4200
	LD R4, backup_R4_4200
	LD R5, backup_R5_4200
	LD R7, backup_R7_4200

	RET
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS.Fill xAA00

backup_R1_4200 		.BLKW #1
backup_R3_4200 		.BLKW #1
backup_R4_4200 		.BLKW #1
backup_R5_4200 		.BLKW #1
backup_R7_4200 		.BLKW #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R1): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
.orig x4400
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;-------------------------------
;HINT back up
ST R2, backup_R2_4400
ST R3, backup_R3_4400
ST R4, backup_R4_4400
ST R5, backup_R5_4400
ST R7, backup_R7_4400

AND R1, R1, #0
AND R2, R2, #0

ADD R2, R2, #1
LDI R3, BUSYNESS_ADDR_FIRST_FREE

AND R4, R4, #0
LD R5, ZOMBIES

PLANTS
	AND R4, R2, R3
	BRnp TIGRA

	ADD R1, R1, #1
	ADD R2, R2, R2
	ADD R5, R5, #-1
	
	BRz EGGPLANT
	BR PLANTS

EGGPLANT
	AND R1, R1, #0
	ADD R1, R1, #-1
TIGRA
;HINT Restore
	LD R2, backup_R2_4400
	LD R3, backup_R3_4400
	LD R4, backup_R4_4400
	LD R5, backup_R5_4400
	LD R7, backup_R7_4400
	RET
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xAA00

ZOMBIES .FILL #16

backup_R2_4400				.BLKW #1
backup_R3_4400				.BLKW #1
backup_R4_4400				.BLKW #1
backup_R5_4400				.BLKW #1
backup_R7_4400 				.BLKW #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------
.orig x4600
;-------------------------------
;INSERT CODE For Subroutine 
;-------------------------------
ST R0, backup_R0_4600
ST R2, backup_R2_4600
ST R3, backup_R3_4600
ST R4, backup_R4_4600
ST R5, backup_R5_4600
ST R7, backup_R7_4600

PIT
	AND R1, R1, #0
	LD R2, DINOSAUR_TRAIN
	
	LEA R0, prompt
	PUTS
	
PERRY
	GETC
	OUT
	
	LD R3, FIRE
	ADD R3, R0, R3
	BRz CHEEK

	LD R3, TAILS
	ADD R3, R0, R3
	BRp OSCAR
	
	LD R3, SHIRO
	ADD R3, R0, R3
	BRn OSCAR
	
	ADD R5, R1, #0
	AND R4, R4, #0
	ADD R4, R4, #9
	
SPICY
	ADD R1, R1, R5
	ADD R4, R4, #-1
	
	BRz QUENCH
	BR SPICY
	
QUENCH
	ADD R1, R1, R3
	ADD R2, R2, #-1
	
	BRz SLASH
	BR PERRY

CHEEK
	ADD R2, R2, #-2
	BRz OSCAR
	BR FLOUR
	
SLASH
	ADD R1, R1, #-16
	BRzp PRE
	
	ADD R1, R1, #15
	ADD R1, R1, #1
	BR POST
	
PRE
	GETC
	OUT
	
OSCAR
	LD R0, NEWT
	OUT
	
	LEA R0, Error_msg_2
	PUTS
	BR PIT
	
POST
	GETC
	OUT
	
FLOUR
	LD R0, backup_R0_4600
	LD R2, backup_R2_4600
	LD R3, backup_R3_4600
	LD R4, backup_R4_4600
	LD R5, backup_R5_4600
	LD R7, backup_R7_4600
	
	RET
;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt			.STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 	.STRINGZ "ERROR INVALID INPUT\n"
NEWT 			.FILL '\n'

backup_R0_4600 	.BLKW #1
backup_R2_4600	.BLKW #1
backup_R3_4600 	.BLKW #1
backup_R4_4600 	.BLKW #1
backup_R5_4600 	.BLKW #1
backup_R7_4600 	.BLKW #1

DINOSAUR_TRAIN 	.FILL #2
FIRE			.FILL #-10
SHIRO 			.FILL #-48
TAILS			.FILL #-57
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,16}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
;                WITHOUT leading 0's, a leading sign, or a trailing newline.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------
.orig x4800
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
ST R0, backup_R0_4800
ST R1, backup_R1_4800
ST R2, backup_R2_4800
ST R3, backup_R3_4800
ST R7, backup_R7_4800

AND R0, R0, #0
LD R2, GBBO

ADD R1, R1, #-10
BRn TRASH

ADD R0, R0, #1
ADD R0, R0, R2
OUT

ADD R1, R1, #-10

TRASH
	ADD R1, R1, #10
	ADD R0, R1, R2
	OUT

	LD R0, backup_R0_4800
	LD R1, backup_R1_4800
	LD R2, backup_R2_4800
	LD R3, backup_R3_4800
	LD R3, backup_R3_4800
	LD R3, backup_R3_4800
	LD R7, backup_R7_4800
	RET
;--------------------------------
;Data for subroutine print number
;--------------------------------
backup_R0_4800 	.BLKW #1
backup_R1_4800 	.BLKW #1
backup_R2_4800 	.BLKW #1
backup_R3_4800 	.BLKW #1
backup_R4_4800 	.BLKW #1
backup_R5_4800 	.BLKW #1
backup_R6_4800 	.BLKW #1
backup_R7_4800 	.BLKW #1
	
GBBO 			.FILL #48
;=======================================================================
.orig x5000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.orig xAA00			; Remote data
BUSYNESS .FILL xABCD		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;---------------	
;END of PROGRAM
;---------------	
.END
