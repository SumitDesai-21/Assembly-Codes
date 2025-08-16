org 100h
; program 1
MOV AL, 00H
MOV BL, 01H
SUB AL, BL
HLT

ret

; program 2
org 100h

MOV AL, 00H
MOV BL, 01H
MOV AH, 04H
MOV BH, 02H
SUB AL, BL 
;SUB AX, BX
SUB AH, BH
HLT

ret
