org 100h     
; Directly you can move segment registers
MOV AX, 2000H
MOV DS, AX
MOV SI, 2000H
CLD ; DF=0
MOV [SI], 55H
LODSB
HLT
; LODSB - load string byte
; it moves address bytes
; increments SI by 1 
; 55h will be transfered into AL
; DS, SI -> transfered into AL register
; memory to register
; memory -> DS, SI
; register -> AL
ret
  

;Key Concept of LODSB
;Source = DS:SI
;Destination = AL
;Pointer update:
;SI += 1 if DF=0 (CLD)  clear direction flag
;SI -= 1 if DF=1 (STD)  set direction flag 
