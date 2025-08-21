org 100h

MOV AX, 2000H
MOV DS, AX          ; DS = 2000h (data segment)
MOV ES, AX          ; ES = 2000h (extra segment) - SCASB reads from ES:DI
MOV DI, 2000H       ; DI = 2000h ? ES:DI points to address 2000:2000
CLD                 ; DF = 0 ? SCASB will increment DI after compare

MOV [2000H], 12H    ; Store 12h at DS:2000 (same physical as ES:2000 here)
MOV AL, 12H         ; AL = 12h (the byte we will search/compare against)

; SCASB: compare AL with byte at ES:DI, set flags, then update DI (DI+=1 since DF=0)
SCASB               ; Flags reflect AL - ES:[DI]; DI becomes 2001h

JZ NEXT             ; Jump if equal (ZF=1). Here it WILL jump because 12h == [2000h].

HLT                 ; If not equal, we would halt here (not taken in this case).

NEXT:
MOV [2001H], AL     ; Write AL (12h) to DS:2001
HLT
ret
