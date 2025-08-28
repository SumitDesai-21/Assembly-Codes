; Q.1 Write an ALP to perform 8-bit and 16-bit block data transfer
; 8 bit block data transfer
org 100h
MOV SI, 2000H
MOV DI, 3000H
MOV CX, 05H

LOOP8:
MOV AL, [SI]
MOV [DI], AL
INC SI
INC DI
DEC CX
JNZ LOOP8
HLT
RET     

; alternate approach using REP MOVSB (moves 8bit data)-optimal
org 100h
MOV SI, 2000H
MOV DI, 3000H
MOV CX, 05H

CLD ; clear direction flag 
REP MOVSB
HLT
RET

; 16 bit block data transfer
org 100h

MOV AX, 2000
MOV DS, AX
MOV AX, 3000
MOV ES, AX

MOV SI, 2000
MOV DI, 3000

CLD 
REP MOVSW
HLT
ret

; alternate approach

org 100h
MOV SI, 2000H
MOV DI, 3000H
MOV CX, 03H

LOOP16: 
MOV AX, [SI]
MOV [DI], AX
ADD SI, 2
ADD DI, 2      
DEC CX
JNZ LOOP16
HLT
ret

; Q.2 Write an ALP to perform 8-bit and 16-bit block data Exchange
; 8 bit block data exchange
org 100h

MOV AX, 2000H
MOV DS, AX
MOV ES, AX

MOV SI, 2000H
MOV DI, 3000H
MOV CX, 05H

EXCHANGE8:
MOV AL, [SI]
MOV BL, [DI]
MOV [SI], BL
MOV [DI], AL
INC SI
INC DI
DEC CX
JNZ EXCHANGE8
HLT
ret

; 16 bit block data exchange
org 100h

MOV AX, 4000H
MOV DS, AX
MOV ES, AX

MOV SI, 4000H
MOV DI, 5000H
MOV CX, 03H

EXCHANGE16:
MOV AX, [SI]
MOV BX, [DI]
MOV [SI], BX
MOV [DI], AX
ADD SI, 2
ADD DI, 2
DEC CX
JNZ EXCHANGE16
HLT
ret
