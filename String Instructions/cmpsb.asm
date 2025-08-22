org 100h

MOV AX, 2000H    ; AX = 2000h
MOV DS, AX       ; DS = 2000h (source segment)
MOV ES, AX       ; ES = 2000h (destination segment)
MOV SI, 2000H    ; SI = offset 2000h (source index)
MOV DI, 2001H    ; DI = offset 2001h (destination index)

CLD              ; Clear Direction Flag (increment SI and DI)
MOV AL, 14H      ; AL = 14h
MOV [2000H], 12H ; Memory at DS:2000 = 12h (source byte)
MOV [2001H], 12H ; Memory at DS:2001 = 12h (destination byte)

CMPSB            ; Compare byte at DS:SI with byte at ES:DI
JZ NEXT           ; Jump to NEXT if Zero Flag (ZF=1 ? bytes are equal)
     
HLT               ; Stop execution here if bytes are different

NEXT:
MOV [2002H], AL   ; If equal, store AL (14h) at DS:2002
HLT               ; Stop execution
ret

