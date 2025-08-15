org 100h

MOV AL, 0FFH 
MOV BL, 0FFH
MOV AH, 0FFH
MOV BH, 0FFH
ADD AL, BL ; ADD:  Adds two operands. Ignores carry flag.
ADC AH, BH ; ADC: Adds two operands + the carry flag.
; ADD AX, BX ; AH + BH & AL + BL
HLT

ret
