; Final Project cin + character function
.ORIG x3000
;Displays Prompt 
LEA R0, USERPROMPT;
PUTS
AND R6, R6, 0

; Gather Userinput
GETLINE
GETC
OUT ;Shows what you are typing
ADD R4, R0, #-10 ; This is the enter key ascii code
BRz CONTINUE ; if enter press continues
JSR DATA
BR GETLINE

;Continues
CONTINUE
LD R1, STRING_HEAD
ADD R1, R1, #1
ST R1, STRING_HEAD
LDI R0, STRING_HEAD
OUT
HALT

;Loop userinput until enter key pressed
USERPROMPT 	.STRINGZ "Enter in a Name: "
STRING_PTR	.FILL 0x3100
STRING_HEAD	.FILL 0x3100

DATA ; Used to store data as a string
LD R5, STRING_PTR ; Loads R5 as STRING_PTR
STI R0, STRING_PTR ; Stores R0 into STRING_PTR
ADD R5, R5, #1 ; Stack increment +1
ST R5, STRING_PTR 
RET
.END