org 100h
MOV AX, 2000H
MOV DS, AX
MOV ES, AX
MOV SI, 2000H
MOV DI, 2010H
CLD ; DF(direction flag) = 0 ; SI will be incremeneted by
; 1 
MOV [2000H], 10H
MOV [2001H], 20H
MOVSB ; copies contents of bytes (automatically increments if DF = 0)
; decrements if DF = 1
MOVSB
HLT
ret
;MOVSB is a shorthand for: 
;MOV AL, [DS:SI]
;MOV [ES:DI], AL
;INC SI  ; if DF = 0
;INC DI

