
org 100h

MOV AX, 2000H
MOV DS, AX
MOV SI, 2000H
CLD              ; Clear direction flag -> SI increments forward
MOV [SI], 55H    ; Store 55h at DS:2000
MOV [SI + 1], 66H; Store 66h at DS:2001
LODSW            ; Load word from DS:SI into AX (AL=55h, AH=66h)
HLT

; LODSW - load string word
; It reads 2 bytes from memory at DS:SI
; Places low byte in AL and high byte in AH (AX = AH:AL)
; Increments SI by 2 because CLD was set (DF=0)

ret
