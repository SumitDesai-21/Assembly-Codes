org 100h                 
MOV AX, 2000H ; AX = 2000h
MOV ES, AX    ; ES = 2000h
MOV DI, 2000H ; DI = 2000h
CLD           ; DF=0 (increment direction)
MOV AL, 34H   ; AL = 34h
STOSB         ; Store the byte in AL into ES:DI and then increment DI (since DF=0)
HLT

; LODSB => DS:SI -> AL ; memory to register
; STOSB => AL -> ES:DI ; register to memory
; After STOSB:
;   - The byte in AL (34h) is stored at ES:DI (2000:2000)
;   - DI is incremented (because DF=0, set by CLD)
;   - If DF=1 (STD), DI would decrement instead.
ret
