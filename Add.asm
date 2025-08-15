org 100h       ; Origin point for COM files (always 100h)

; program 1
MOV AL, 01H
MOV BL, 02H
ADD AL, BL
MOV [2000H], AL
HLT

; program 2
MOV AX, 1111H
MOV BX, 2222H
ADD AX, BX
MOV [2000H], AX
HLT

; program 3
mov AL, 5      ; Load 5 into AL
add AL, 3      ; Add 3 to AL (AL = AL + 3)

ret            ; Return control to OS

