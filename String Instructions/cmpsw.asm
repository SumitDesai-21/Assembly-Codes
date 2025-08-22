org 100h

MOV AX, 2000H
MOV DS, AX
MOV ES, AX
MOV SI, 2000H
MOV DI, 2002H

CLD  ; DF=0
MOV Al, 16H
MOV [2000H], 12H
MOV [2001H], 14H
MOV [2002H], 12H
MOV [2003H], 14H
CMPSW ; result is not stored only compared.  
; DS:SI compared with ES:DI
; 1412h - 1412h = 0 (it is zero i.e ZF=1)

JZ NEXT
     
HLT
NEXT: MOV [2004H], AL
HLT
             ; forward -> STD (DF=1)
             ; backward -> CLD (DF=0)
ret
