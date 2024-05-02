DATA_SEG SEGMENT 
    num DW 0005h  ; Define a word (16-bit) variable num with value 5
DATA_SEG ENDS 

CODE_SEG SEGMENT 
    ASSUME CS:CODE_SEG, DS:DATA_SEG
START:
    MOV AX, DATA_SEG   ; Load data segment address into AX
    MOV DS, AX         ; Initialize DS with the data segment address

    MOV AX, 01H        ; Set AX to 1 (for return value storage)
    MOV BX, num        ; Move the value of num into BX
    CALL fact          ; Call the factorial procedure
    MOV DI, AX         ; Move the result of the factorial calculation into DI

    MOV AH, 4CH        ; Set AH to the exit code
    INT 21H            ; Call the DOS interrupt to terminate the program

fact proc near
    CMP BX, 1         ; Compare BX with 1
    JZ L11            ; If BX is 1, jump to label L11
    MOV CX, BX        ; Move the value of BX into CX (for calculation)
    DEC BX            ; Decrement BX
L12:
    MUL CX            ; Multiply AX by CX
    DEC CX            ; Decrement CX
    CMP CX, 1         ; Compare CX with 1
    JNE L12           ; If CX is not 1, jump to label L12
    RET               ; Return from the procedure
L11:
    MOV AX, 1         ; If BX is 1, set AX to 1 (base case)
    RET               ; Return from the procedure
fact endp

CODE_SEG ENDS 
END START
