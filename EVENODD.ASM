DATA_SEG SEGMENT
    ARR_1 DB 28H,11H,22H,33H,44H,55H,34H,66H,88H,94H  ; Define the array of bytes
    EVEN_NO DB 0     ; Define a variable to store the count of even numbers
    ODD_NO DB 0      ; Define a variable to store the count of odd numbers
DATA_SEG ENDS

CODE_SEG SEGMENT
ASSUME CS:CODE_SEG, DS:DATA_SEG

START:
    MOV AX, DATA_SEG  ; Load data segment address into AX
    MOV DS, AX        ; Initialize DS with the data segment address

    MOV SI, OFFSET ARR_1  ; Initialize SI with the offset address of ARR_1
    MOV CX, 10             ; Initialize CX with the number of elements in the array

AGAIN:
    MOV AL, [SI]   ; Copy the contents of memory into AL
    ROR AL, 1      ; Rotate the least significant bit to the carry flag

    JC SKIP        ; If the carry flag is set, skip incrementing the count of even numbers
    INC EVEN_NO    ; Increment the count of even numbers
    JMP NEXT       ; Jump to NEXT to continue processing the next element

SKIP:
    INC ODD_NO     ; Increment the count of odd numbers

NEXT:
    INC SI         ; Move to the next element in the array
    LOOP AGAIN     ; Repeat the loop until all elements are processed

    MOV AH, 4CH    ; Exit to DOS
    INT 21H        ; Call the DOS interrupt to terminate the program

CODE_SEG ENDS
END START
