DATA_SEG SEGMENT
    ARR_1 DB 'abcba' ; Define the string
    LEN DW 5         ; Define the length of the string
    PAL DB ?         ; Define a variable to store whether the string is a palindrome or not
DATA_SEG ENDS

CODE_SEG SEGMENT
ASSUME CS:CODE_SEG, DS:DATA_SEG
START:
    MOV AX, DATA_SEG  ; Load data segment address into AX
    MOV DS, AX        ; Initialize DS with the data segment address

    MOV SI, OFFSET ARR_1  ; Initialize SI with the offset address of ARR_1 (start pointer)
    MOV DI, SI             ; Initialize DI with the offset address of ARR_1 (end pointer)
    MOV BX, LEN            ; Load BX with the length of the string
    DEC BX                 ; Decrement BX to get the index of the last character in the string
    ADD DI, BX             ; Move DI to point to the last character of the string

AGAIN:
    MOV AL, [SI]    ; Load AL with the character pointed by SI
    CMP AL, [DI]    ; Compare AL with the character pointed by DI
    JNZ NO_PAL      ; Jump to NO_PAL if characters are not equal
    INC SI          ; Move SI to point to the next character in the string
    DEC DI          ; Move DI to point to the previous character in the string
    CMP SI, DI      ; Compare SI with DI
    JNC AGAIN       ; Jump to AGAIN if SI is not greater than DI (still characters to compare)

PALINDROME:
    ; Code to execute if the string is a palindrome
    MOV PAL, 1     ; Set PAL to 1 indicating the string is a palindrome
    JMP END_PROGRAM

NO_PAL:
    ; Code to execute if the string is not a palindrome
    MOV PAL, 0     ; Set PAL to 0 indicating the string is not a palindrome
    JMP END_PROGRAM

END_PROGRAM:
    ; End of the program
    ; Add additional code here if needed
CODE_SEG ENDS
    END START
