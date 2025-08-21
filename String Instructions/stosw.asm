org 100h

MOV AX, 2000H ; AX = 2000h
MOV ES, AX    ; ES = 2000h
MOV DI, 2000H ; DI = 2000h
CLD           ; DF=0
MOV AX, 1234H ; AX = 1234h

STOSW ; Store AX at ES:DI and update DI acc to DF flag
; here DF=0 (CLD) 
; DI += 2 i.e DI = 2002h   
; 2000:2000 -> low byte AL(34h)
; 2000:2001 -> high byte AH(12h)
HLT
ret

