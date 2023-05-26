; Final Project cin + character function
.ORIG x3000
;Displays Prompt 
LEA R0, USERPROMPT;
PUTS
AND R6, R6, 0
AND R5, R5, #0

; Gather Userinput, Uses R4 to check only, doesn't need to be global
GETLINE
GETC
OUT ;Shows what you are typing
ADD R4, R0, #-10 ; This is the enter key ascii code
BRz CONTINUE ; if enter press continues
JSR DATA
BR GETLINE

;Continues 
CONTINUE

;Saves Max characters in the string
ADD R3, R3, #-1
STI R3, MAX_STRING
;Time to count
LD R1, STRING_HEAD
;Copies R5 into R6 for loop increments
ADD R6, R3, #0
;R3, R4 holds counted stacked for original string
LD R3, COUNT_ARRAY

COUNT
;R1, R2 holds original string items
LD R7, STRING_HEAD
ST R1, STRING_PTR
LDI R2, STRING_PTR
LDI R5, MAX_STRING
NOT R2, R2 
;ADD R2, R2, #1 ;2s complement
;R5, R6 holds the loop increments
COUNT_LOOP
AND R4, R4, #0
;R7 is for the loop to search for the same value as R2
ST R7, STRING_PTR
LDI R0, STRING_PTR
ADD R0, R0, R2 
BRz COUNTER
NEXT_COUNT
ADD R7, R7, #1
ADD R5, R5, #-1
BRp COUNT_LOOP
ADD R1, R1, #1 ; goes to the next memory in the stack
STI R4, COUNT_ARRAY
ADD R3, R3, #1 ; goes to the next memory in the array
ST R3, COUNT_ARRAY
ADD R6, R6, #-1
BRp COUNT
; R0 here is just a placeholder as a boolean statement

LEA R0, PROMPT
PUTS
; Displays it
LD R2, STRING_HEAD
LD R3, COUNT_ARRAY_TOP
ST R2, STRING_PTR
ST R3, COUNT_ARRAY
LDI R6, MAX_STRING
OUTPUT
LDI R0, STRING_PTR
OUT
LDI R0, COUNT_ARRAY
OUT
; Displays an Enter
LEA R0, ENTER 
PUTS
; Next increment in the loop
ADD R2, R2, #1
ADD R3, R3, #1
ST R2, STRING_PTR
ST R3, COUNT_ARRAY
ADD R6, R6, #-1
BRp OUTPUT
HALT

;Loop userinput until enter key pressed
PROMPT			.STRINGZ "Counting...\n" 
USERPROMPT 		.STRINGZ "Enter in a Name: "
STRING_PTR		.FILL 0x3100
STRING_HEAD		.FILL 0x3100
COUNT_ARRAY		.FILL 0x3200
COUNT_ARRAY_TOP	.FILL 0x3200
MAX_STRING		.FILL 0x3150
ENTER 			.STRINGZ "\n"
;Uses R5 & R6
DATA ; Used to store data as a string
LD R5, STRING_PTR ; Loads R5 as STRING_PTR
STI R0, STRING_PTR ; Stores R0 into STRING_PTR
ADD R5, R5, #1 ; Stack increment +1
ADD R3, R3, #1 ; tracks stack size
ST R5, STRING_PTR ;SET PTR to increment
RET

COUNTER
ADD R4, R4, #1
BR NEXT_COUNT
.END