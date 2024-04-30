DATA_SEG SEGMENT
    ORG 25000H       ; Origin address of the data block
    DB 1024 DUP(?)   ; Define 1 KB of data, uninitialized
DATA_SEG ENDS

CODE_SEG SEGMENT
START:
    MOV AX, DATA_SEG
    MOV DS, AX       ; Load data segment address into DS
    MOV SI, 0        ; Source index pointing to the beginning of the data block
    
    MOV AX, 48000H   ; Load intermediate location address into AX
    MOV ES, AX       ; Load intermediate location address into ES
    MOV DI, 0        ; Destination index pointing to the beginning of the intermediate location

    MOV CX, 1024     ; Set the loop counter to copy 1 KB of data
    REP MOVSB        ; Repeat move string operation to copy the data block to intermediate location
    
    MOV AX, 36000H   ; Load destination location address into AX
    MOV ES, AX       ; Load destination location address into ES
    MOV DI, 0        ; Destination index pointing to the beginning of the destination location
    
    MOV CX, 1024     ; Set the loop counter to copy 1 KB of data
    REP MOVSB        ; Repeat move string operation to copy the data block to destination location

    ; Your additional code here, if any

    MOV AH, 4CH      ; Exit program
    INT 21H

CODE_SEG ENDS
    END START
