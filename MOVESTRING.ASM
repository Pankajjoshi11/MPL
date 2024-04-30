DATA_SEG SEGMENT
    source_arr DB 28H,11H,22H,33H,44H  ; Define the source array
    dest_arr DB 5 DUP (?)               ; Define the destination array
DATA_SEG ENDS

CODE_SEG SEGMENT
    ASSUME CS:CODE_SEG, DS:DATA_SEG

START:
    MOV AX, DATA_SEG  ; Load data segment address into AX
    MOV DS, AX        ; Initialize DS with the data segment address

    LEA SI, source_arr  ; Load the effective address of source_arr into SI
    LEA DI, dest_arr    ; Load the effective address of dest_arr into DI

    MOV CX, 5           ; Load the counter with the number of elements to copy

NEXT:
    MOV AL, [SI]    ; Read the source array element into AL
    MOV [DI], AL    ; Store the element in the destination array
    INC SI          ; Increment the source pointer
    INC DI          ; Increment the destination pointer
    LOOP NEXT       ; Decrement CX by 1 and loop if not zero

    MOV AH, 4CH     ; Exit to DOS
    INT 21H         ; Call DOS interrupt to terminate the program

CODE_SEG ENDS
END START
