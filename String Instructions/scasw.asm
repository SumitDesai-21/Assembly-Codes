org 100h

MOV AX, 2000H
MOV DS, AX
MOV ES, AX
MOV SI, 2000H
MOV DI, 2002H

CLD
MOV AX, 1234H
MOV [2002H], 34H
MOV [2003H], 12H

SCASW ; compare AL with byte at ES:DI, set flags(ZF), then update DI (DI+=2 since DF=0)
JZ NEXT
     
HLT
NEXT: MOV [2004H], AL
HLT

ret
