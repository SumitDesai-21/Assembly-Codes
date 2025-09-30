
; MENU DRIVEN PROGRAM
.MODEL SMALL
.STACK 100H
.DATA     
    ; initialized
    NO1 DB 00H
    NO2 DB 00H 
    NO3 DW 00H
    RES DW 00H
    OPR DB 00H
    
    MSG DB 10,13, "DO YOU WANT TO CONTINUE:", 13,10, "1. YES", 13,10,"2. NO", 13,10,"$"
    MSG1 DB 10,13,"ENTER FIRST 8-BIT NUMBER: $"
    MSG2 DB 10,13,"ENTER SECOND 8-BIT NUMBER: $"
    MSG3 DB 10,13,"SELECT OPERATION:",13,10,"1. Addition",13,10,"2. Subtraction",13,10,"3. Multiplication",13,10,"4. Division",13,10,"Enter choice (1 or 2 or 3 or 4): $"
    MSG4 DB 10,13,"ENTER FIRST 16-BIT NUMBER: $"
    MSGR DB 10,13,"RESULT IS : $"
    MSGQ DB 10,13,"QUOTIENT : $"
    MSGREM DB 10,13,"REMAINDER: $"
    DIVZERO DB 10,13,"ERROR: Division by zero!$"
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
CONTINUE:        
    LEA DX, MSG3
    MOV AH, 09H
    INT 21H     
    
    MOV AH, 01H      
    INT 21H
    SUB AL, 48
    MOV OPR, AL  
    MOV AL, OPR
    
    ; Check if division operation
    CMP AL, 4
    JE DIV_FIRST_INPUT
    
    ; first input
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H
    CALL ACCEPT
    MOV NO1, BL    
    
    ; second input
    CALL SECOND_INPUT
    JMP OPERATIONS
    
DIV_FIRST_INPUT:
    ; for division= 16-bit first input
    LEA DX, MSG4
    MOV AH, 09H
    INT 21H 
    CALL ACCEPT16
    MOV NO3, BX
    
    ; 8 bit 2nd input
    CALL SECOND_INPUT
    JMP OPERATIONS

OPERATIONS:
    MOV AL, OPR 
    CMP AL, 1
    JE ADDITION
    CMP AL, 2
    JE SUBTRACTION
    CMP AL, 3
    JE MULTIPLICATION 
    CMP AL, 4
    JE DIVISION
    JMP EXIT 

ADDITION:
    XOR AX, AX
    MOV AL, NO1
    ADD AL, NO2
    MOV RES, AX
    JMP DISPLAY

SUBTRACTION:
    XOR AX, AX
    MOV AL, NO1
    SUB AL, NO2
    MOV RES, AX
    JMP DISPLAY

MULTIPLICATION:
    XOR AX, AX
    MOV AL, NO1
    MOV BL, NO2
    MUL BL          
    MOV RES, AX    
    JMP DISPLAY

DIVISION:
    ; Check for division by zero
    CMP NO2, 0
    JE DIV_BY_ZERO
    
    MOV AX, NO3     
    XOR DX, DX      
    XOR BH, BH      
    MOV BL, NO2     
    DIV BX       
    ; AX = quotient & DX = remainder
    
    MOV RES, AX     
    PUSH DX ; save remainder into stack
    
    ; Display quotient
    LEA DX, MSGQ
    MOV AH, 09H
    INT 21H
    MOV BX, RES
    CALL PRINT16
    
    ; Display remainder
    LEA DX, MSGREM
    MOV AH, 09H
    INT 21H
    POP BX   ; get remainder from stack
    CALL PRINT16
    JMP CONTINUE_PROMPT

DIV_BY_ZERO:
    LEA DX, DIVZERO
    MOV AH, 09H
    INT 21H
    JMP CONTINUE_PROMPT


DISPLAY_DIVISION:
    ; Display quotient
    LEA DX, MSGQ
    MOV AH, 09H
    INT 21H
    MOV BL, AL      ; mov quotient to BL
    CALL PRINT
    
    ; Display remainder  
    LEA DX, MSGREM
    MOV AH, 09H
    INT 21H
    MOV BL, AH      ; Move remainder to BL for printing
    CALL PRINT
    JMP CONTINUE_PROMPT
           
; display program for addition, subtraction & multiplication
DISPLAY:
    LEA DX, MSGR
    MOV AH, 09H
    INT 21H
    MOV BX, RES
    CALL PRINT16  ; for 16 bit results
    JMP CONTINUE_PROMPT

CONTINUE_PROMPT:
    ; ask user if you want to continue
    LEA DX, MSG
    MOV AH, 09H 
    INT 21H   
    
    MOV AH, 01H
    INT 21H
    SUB AL, 48
    CMP AL, 1
    JE CONTINUE
    JMP EXIT

EXIT:
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP

; Procedure to get second input
SECOND_INPUT PROC
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H        
    CALL ACCEPT    
    MOV NO2, BL  
    RET
SECOND_INPUT ENDP

; print procedure = prints single byte in BL as hex
PRINT PROC
    MOV CH, 02H
    MOV CL, 04H
BA: ROL BL, CL
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 0AH
    JC L1
    ADD DL, 07H
L1: ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC CH
    JNZ BA 
    RET    
PRINT ENDP
    
; Accept procedure = accepts 2 digit hex input
ACCEPT PROC
    MOV CH, 02H
    MOV CL, 04H
    MOV BL, 00H
BACK: SHL BL, CL
    MOV AH, 01H
    INT 21H
    CMP AL, 41H
    JC L2
    SUB AL, 07H
L2: SUB AL, 30H
    ADD BL, AL ;BL = BL + AL
    DEC CH
    JNZ BACK
    RET
ACCEPT ENDP
            
; Accept procedure for 16 bit input 
ACCEPT16 PROC
    MOV CH, 04H     
    MOV CL, 04H     
    MOV BX, 0000H   
BACK16: SHL BX, CL 
    MOV AH, 01H
    INT 21H
    CMP AL, 41H 
    JC L2_16
    SUB AL, 07H     
L2_16: SUB AL, 30H  
    ADD BL, AL 
    DEC CH
    JNZ BACK16
    RET
ACCEPT16 ENDP

; Print procedure for 16 bit values
PRINT16 PROC
    MOV CH, 04H     
    MOV CL, 04H     
BA16: ROL BX, CL    
    MOV DL, BL
    AND DL, 0FH     
    CMP DL, 0AH
    JC L1_16
    ADD DL, 07H     
L1_16: ADD DL, 30H  
    MOV AH, 02H
    INT 21H
    DEC CH
    JNZ BA16 
    RET
PRINT16 ENDP

END MAIN