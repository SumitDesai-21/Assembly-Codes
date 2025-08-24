; push and pop -> Used to save and restore data in the stack.

org 100h

MOV AX, 1234h
PUSH AX      ; Save AX
MOV AX, 0    ; Clear AX
POP AX       ; Get back 1234h

;PUSH AX  ; Save AX into stack (SP -= 2)
;POP AX   ; Restore AX from stack (SP += 2)
HLT
ret
