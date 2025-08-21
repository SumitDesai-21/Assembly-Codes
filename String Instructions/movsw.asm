org 100h

MOV AX, 2000H
; CLD (CLEAR DIRECTION FLAG)
MOV DS, AX
MOV ES, AX
MOV SI, 2000H
MOV DI, 2010H
CLD ; here DF is set to zero  
MOV [2000H], 40H
MOV [2001H], 50H
MOVSW ; move string word   
;  move word from DS:SI -> ES:DI (2 bytes)
HLT

ret
; SB - String bytes (incremented/decremented by 1), 
; SW - String words (incremented/decremented by 2)
