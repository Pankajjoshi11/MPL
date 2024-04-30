DATA_SEG SEGMENT
    PBCD DB 26H    ; Define the byte containing the packed BCD value
    DIG1 DB ?      ; Define a variable to store the first digit
    DIG2 DB ?      ; Define a variable to store the second digit
DATA_SEG ENDS

CODE_SEG SEGMENT
ASSUME CS:CODE_SEG, DS:DATA_SEG

START:
    MOV AX, DATA_SEG  ; Load data segment address into AX
    MOV DS, AX        ; Initialize DS with the data segment address

    MOV AL, PBCD      ; Move the packed BCD value into AL

    ; Extract the first BCD digit (lower 4 bits)
    AND AL, 0FH       ; Mask the lower 4 bits
    MOV DIG1, AL      ; Store the result in DIG1

    ; Extract the second BCD digit (upper 4 bits)
    MOV AL, PBCD      ; Move the packed BCD value into AL again
    AND AL, 0F0H      ; Mask the upper 4 bits
    MOV CL, 04H       ; Set the rotation count to 4 (to align the bits)
    ROL AL, CL        ; Rotate left the bits by 4 positions
    MOV DIG2, AL      ; Store the result in DIG2

    MOV AH, 4CH       ; Set AH to the exit c
