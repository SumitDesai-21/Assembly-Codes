
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
; CALL ? jumps to a subroutine and saves return address in stack.
; RET ? returns to the saved address.  
                  
CALL PRINT_MSG   ; Call procedure
HLT
ret

PRINT_MSG:
    MOV DX, OFFSET MSG
    MOV AH, 09h
    INT 21h
    RET

MSG DB 'Hello, World!$'
ret




