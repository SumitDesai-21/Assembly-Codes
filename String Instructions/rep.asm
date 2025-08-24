org 100h

; Initialize segments
MOV AX, 2000h
MOV DS, AX        ; DS points to source
MOV ES, AX        ; ES points to destination

MOV SI, 2000h     ; Source offset
MOV DI, 3000h     ; Destination offset
MOV CX, 05h       ; Copy 5 bytes

CLD               ; Auto-increment SI, DI
REP MOVSB         ; Repeat MOVSB CX times

HLT
ret

;MOVSB moves byte from DS:SI → ES:DI
;REP repeats the operation until CX = 0.
