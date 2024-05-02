DATA_SEG SEGMENT
    NUM1 DB 28H ; Binary number to be analyzed
    ONES DB 0   ; Variable to store the count of ones
    ZEROS DB 0  ; Variable to store the count of zeros
DATA_SEG ENDS

CODE_SEG SEGMENT
    ASSUME CS:CODE_SEG, DS:DATA_SEG
START:
    MOV AX, DATA_SEG   ; Load data segment address into AX
    MOV DS, AX         ; Initialize DS with the data segment address

    MOV AL, NUM1       ; Load the binary number into AL

    MOV CX, 8          ; Set the counter to 8 (8 bits in a byte)

BACK:
    ROR AL, 1          ; Rotate AL right by 1 bit (this shifts the least significant bit into the carry flag)
    JC CARRY1          ; If the carry flag is set, jump to label CARRY1 (indicates a one)

    INC ZEROS          ; Increment the count of zeros
    JMP EXIT           ; Jump to label EXIT to exit the loop

CARRY1:
    INC ONES           ; Increment the count of ones

EXIT:
    LOOP BACK          ; Decrement CX and loop back if CX is not zero

    MOV AH, 4CH        ; Set AH to the exit code
    INT 21H            ; Call the DOS interrupt to terminate the program

CODE_SEG ENDS
END START
