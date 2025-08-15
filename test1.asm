; Test-1: Increment decrement program
org 100h
MOV CL, 05H       ; Loop counter = 5
MOV SI, 4000H     ; Source address
MOV DI, 5000H     ; Destination address

start_loop:       ; Label to jump back to
MOV AL, [SI]      ; Load byte from SI into AL
MOV BL, [DI]      ; Load byte from DI into BL
MOV [DI], AL      ; Store AL into DI location
MOV [SI], BL      ; Store BL into SI location

INC SI            ; SI = SI + 1
INC DI            ; DI = DI + 1
DEC CL            ; CL = CL - 1
JNZ start_loop    ; Jump to label if CL != 0

HLT               ; Stop program
ret
