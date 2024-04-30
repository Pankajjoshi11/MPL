DATA_SEG SEGMENT
    NUM1 DW 1234H  ; Declare NUM1 and initialize it with the value 1234H
    NUM2 DW 5678H  ; Declare NUM2 and initialize it with the value 5678H
    SUM DW 0       ; Declare SUM and initialize it with the value 0
DATA_SEG ENDS

CODE_SEG SEGMENT
ASSUME CS:CODE_SEG, DS:DATA_SEG

START:
    MOV AX, DATA_SEG  ; Load data segment address into AX
    MOV DS, AX        ; Initialize DS with the data segment address

    MOV AX, NUM1  ; Load the first number into AX
    MOV BX, NUM2  ; Load the second number into BX

    ADD AL, BL    ; Add the two lower bytes
    DAA           ; Decimal Adjust after Addition (DAA) to correct invalid BCD result

    MOV CL, AL    ; Move the result to CL
    MOV AL, AH    ; Move the higher byte to AL
    ADC AL, BH    ; Add the two higher bytes with carry
    DAA           ; Decimal Adjust after Addition (DAA) to correct invalid BCD result

    MOV CH, AL    ; Store the higher byte addition result in CH
    MOV SUM, CX   ; Store the complete addition result in SUM

    MOV AH, 4CH   ; Set AH to the exit code
    INT 21H       ; Call the DOS interrupt to terminate the program

CODE_SEG ENDS
END START
