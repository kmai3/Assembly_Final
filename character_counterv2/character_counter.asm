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
; Sets used Registers to 0
AND R4, R4, #0
AND R3, R3, #0
AND R6, R6, #0
; Sets R5 to negative
ADD R5, R5, #-1 ;Extra 1
NOT R5, R5
ADD R5, R5, #1 ; 2s complement 
;Makes new array based on unique 
LD R3, STRING_HEAD
LDI R4, STRING_HEAD
LD R6, NEW_ARRAY
STI R4, NEW_ARRAY
; THIS MAAY BE USELESS ADD R1, R1, #1 ;Increase Increment of the New Stack
ADD R3, R3, #1 ; Read up from old stack 
ADD R6, R6, #1 ; Size of the new array
ST R3, STRING_PTR ; SET NEW increment 
ST R6, NEW_ARRAY  

CONFIRM_ARRAY
LD R3, STRING_PTR
LDI R4, STRING_PTR
; Copies R6 to R0
AND R7, R7, #0
ADD R0, R6, #0 
;Uses R0 
CHECK_REPEAT
LDI R2, NEW_ARRAY ;
NOT R2, R2 
ADD R2, R2, #1 ;2s complement
ADD R7, R2, R4 ; checks if they are equal
BRz NEXT_CHECK ; there is a repeat
ADD R0, R0, #-1 ; Decrease the decrement to stop 
BRp NEXT_ARRAY 

; Will Run if no matches 
STI R4, NEW_ARRAY
ADD R6, R6, #1
ST R6, NEW_ARRAY

NEXT_CHECK ; Goes up to the next character in original stack
ADD R3, R3, +1
ST R3, STRING_PTR
LDI R4, NEW_ARRAY
ADD R7, R5, R3
BRn CONFIRM_ARRAY

;TIME TO FINALLY COUNT`
AND R1, R1, #0
; Copies R6 into R0 once again, R6 being the size of NEW_ARRAY
; ADD R0, R6, #0, useless just save the max variables 
STI R6, MAX_ARRAY
AND R1, R1, #0

COUNT
AND R7, R7, #0
AND R6, R6, #0
LD R2, NEW_ARRAY_HEAD ; load address of array head to replace array
ST R2, NEW_ARRAY
LDI R1, NEW_ARRAY ; Gets the first character from the array of unique characters
LD R3, STRING_HEAD
ST R3, STRING_PTR
CHECK_ARRAY
LDI R4, STRING_PTR
NOT R4, R4 ; negative
ADD R4, R4, #1 ;2s complement
ADD R4, R4, R1 ; compares the two arrays
BRz COUNTER ;Uses Register 7 to count
NEXT_COUNT
ADD R3, R3, #1
ST R3, STRING_PTR
ADD R6, R6, #1 ;increment of inner for loop
ADD R4, R6, R5 
BRn CHECK_ARRAY 
; prepares new variables to be compared
LD R4, COUNT_ARRAY
ADD R7, R7, #15 ; ascii code 
ADD R7, R7, #15 ; ascii code 
ADD R7, R7, #15 ; ascii code 
ADD R7, R7, #3 ; ascii code
STI R7, COUNT_ARRAY
ADD R4, R4, #1
ST R4, COUNT_ARRAY
ADD R2, R2, #1
ST R2, NEW_ARRAY
LDI R1, NEW_ARRAY
ADD R0, R0, #-1 ;increment of outer for loop
BRp COUNT

LEA R0, PROMPT
PUTS
; Displays it
LD R2, NEW_ARRAY_HEAD
LD R3, COUNT_ARRAY_TOP
ST R2, NEW_ARRAY
ST R3, COUNT_ARRAY
LDI R6, MAX_ARRAY
OUTPUT
LDI R0, NEW_ARRAY
OUT
LDI R0, COUNT_ARRAY
OUT
ADD R2, R2, #1
ADD R3, R3, #1
ST R2, NEW_ARRAY
ST R3, COUNT_ARRAY
ADD R6, R6, #-1
BRp OUTPUT
HALT

;Loop userinput until enter key pressed
PROMPT			.STRINGZ "Character Counter" 
USERPROMPT 		.STRINGZ "Enter in a Name: "
STRING_PTR		.FILL 0x3100
STRING_HEAD		.FILL 0x3100
NEW_ARRAY		.FILL 0x3200
NEW_ARRAY_HEAD	.FILL 0x3200
COUNT_ARRAY		.FILL 0x3300
COUNT_ARRAY_TOP	.FILL 0x3300
MAX_ARRAY		.FILL 0x3400
;MAX_STRING		.FILL 0x3401
;Uses R5 & R6
DATA ; Used to store data as a string
LD R5, STRING_PTR ; Loads R5 as STRING_PTR
STI R0, STRING_PTR ; Stores R0 into STRING_PTR
ADD R5, R5, #1 ; Stack increment +1
ST R5, STRING_PTR ;SET PTR to increment
RET

;Loop to go to the next in the ARRAY 
NEXT_ARRAY
LD R7, NEW_ARRAY_HEAD ; Goes back to the start
ADD R7, R7, R0 ; ADDS r7 with R0  
ST R7, NEW_ARRAY ; Sets NEW_ARRAY LOCATION
BR CHECK_REPEAT ; Goes back to checking

COUNTER
ADD R7, R7, #1
BR NEXT_COUNT
.END