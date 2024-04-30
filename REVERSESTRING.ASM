DATA_SEG SEGMENT
    MAX_SIZE EQU 100    ; Define the maximum size of the string
    INPUT_STRING DB MAX_SIZE DUP('$') ; Define the input string
    REVERSED_STRING DB MAX_SIZE DUP('$') ; Define the reversed string
DATA_SEG ENDS

CODE_SEG SEGMENT
ASSUME CS:CODE_SEG, DS:DATA_SEG

START:
    MOV AX, DATA_SEG   ; Load data segment address into AX
    MOV DS, AX         ; Initialize DS with the data segment address

    ; Define the input string
    MOV SI, OFFSET INPUT_STRING
    MOV BYTE PTR [SI], 'Hello, world!' ; Define the string to be reversed

    ; Get the length of the string
    XOR CX, CX         ; Clear CX register
    MOV SI, OFFSET INPUT_STRING  ; Point SI to the input string
GET_LENGTH_LOOP:
    LODSB              ; Load a byte from SI into AL and increment SI
    CMP AL, '$'        ; Check if the current character is the null terminator
    JE CALC_LENGTH     ; If null terminator found, jump to calculate length
    INC CX             ; Increment CX to count the length of the string
    JMP GET_LENGTH_LOOP ; Repeat until null terminator is found

; Calculate the length of the string
CALC_LENGTH:
    MOV DI, CX         ; Copy the length of the string to DI
    DEC DI             ; Adjust DI to point to the last character of the string
    MOV BX, DI         ; Copy DI to BX for later use

; Reverse the string
REVERSE_LOOP:
    MOV AL, [INPUT_STRING + DI]  ; Load a character from the input string
    MOV [REVERSED_STRING + BX], AL  ; Store the character in the reversed string
    DEC DI             ; Move DI to the previous character of the input string
    DEC BX             ; Move BX to the next position of the reversed string
    CMP DI, 0          ; Check if DI has reached the beginning of the input string
    JGE REVERSE_LOOP   ; If not, continue the loop

; Terminate the reversed string
    MOV BYTE PTR [REVERSED_STRING + CX], '$'  ; Add null terminator to the end of the reversed string

; Display the reversed string
    MOV AH, 09H        ; Function code for displaying a string
    LEA DX, REVERSED_STRING  ; Load DX with the offset address of the reversed string
    INT 21H            ; Call DOS interrupt to display the reversed string

    MOV AH, 4CH        ; Exit to DOS
    INT 21H            ; Call DOS interrupt to terminate the program

CODE_SEG ENDS
END START
