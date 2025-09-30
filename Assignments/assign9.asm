.MODEL SMALL
.STACK 100H
.DATA 
    MSG DB 10, 13, "Enter a choice:", 10, 13, "01. Find ONE'S compliment of 8 & 16 bit numbers.", 10, 13, "02. Find TWO'S compliment of 8 & 16 bit numbers.", 10, 13, "03. Mask 4 LSB of 8 bit number.", 10, 13, "04. Mask 4 MSB of 8 bit number.",10, 13, "05. Mask 8 LSB of 16 bit number.", 10, 13, "06. Mask 8 MSB of 16 bit number.", 10, 13, "07. Shift an 8 bit number to the left.", 10, 13, "08. Shift an 8 bit number to the right.", 10, 13, "09. Shift a 16-bit number to the left.", 10, 13, "10. Shift a 16-bit number to the right.", 10, 13, "11. Check whether a number is even or odd.", 10, 13, "$"
    OPR DB 0 
    MSG1 DB 10, 13, "Enter a 8 bit number: $"
    MSG2 DB 10, 13, "Enter a 16 bit number: $"
    MSG3 DB 10, 13, "Do you want to continue?", 10, 13, "1. Yes", 10, 13, "2. No", 10, 13,"$"
    MSG4 DB 10, 13, "Shift a number by (8-bit): $" 
    MSG5 DB 10, 13, "Choose 1 or 2:", 10, 13, "1. 8 bit number", 10, 13, "2. 16 bit number", 10, 13, "$"
    MSG6 DB 10, 13, "Given number is even.$"
    MSG7 DB 10, 13, "Given number is odd.$"         
    OP1 DB 10, 13, "ONE'S compliment is (result): $" 
    OP2 DB 10, 13, "TWO'S compliment is (result): $" 
    OP3 DB 10, 13, "After masking 4 bits (result): $"  
    OP4 DB 10, 13, "After masking 8 bits (result): $"
    OP5 DB 10, 13, "After shifting bits (result): $"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    CONTINUE:  
        LEA DX, MSG
        MOV AH, 09H
        INT 21H 
        
        
        CALL ACCEPT
        MOV AL, BL
        MOV OPR, AL  
        
        MOV AL, OPR
        CMP AL, 01   
        JE PROGRAM1
        CMP AL, 02
        JE PROGRAM2 
        CMP AL, 03
        JE PROGRAM3 
        CMP AL, 04
        JE PROGRAM4
        CMP AL, 05
        JE PROGRAM5
        CMP AL, 06
        JE PROGRAM6
        CMP AL, 07
        JE PROGRAM7 
        CMP AL, 08
        JE PROGRAM8
        CMP AL, 09
        JE PROGRAM9
        CMP AL, 16 ; 1*16 + 0 = 16
        JE PROGRAM10 
        CMP AL, 17 ; 1*16+1*1 = 17
        JE PROGRAM11
        JMP EXIT
    
    PROGRAM1:   
        LEA DX, MSG1     
        MOV AH, 09H      
        INT 21H 
        XOR AX, AX
        CALL ACCEPT 
        MOV AL, BL     
        NOT AL ; ONE'S COMPLIMENT
        MOV BL, AL 
        
        LEA DX, OP1
        MOV AH, 09H
        INT 21H
        CALL PRINT 
        
        LEA DX, MSG2
        MOV AH, 09H  
        INT 21H
        
        XOR AX, AX
        CALL ACCEPT16
        MOV AX, BX
        NOT AX
        MOV BX, AX
        
        LEA DX, OP1
        MOV AH, 09H
        INT 21H
        CALL PRINT16  
        
        JMP ASK_USER
        
    PROGRAM2: 
        LEA DX, MSG1     
        MOV AH, 09H      
        INT 21H 
        XOR AX, AX
        CALL ACCEPT 
        MOV AL, BL     
        NEG AL ; ONE'S COMPLIMENT
        MOV BL, AL 
        
        LEA DX, OP2
        MOV AH, 09H
        INT 21H
        CALL PRINT 
        
        LEA DX, MSG2
        MOV AH, 09H  
        INT 21H
        
        XOR AX, AX
        CALL ACCEPT16
        MOV AX, BX
        NEG AX
        MOV BX, AX
        
        LEA DX, OP2
        MOV AH, 09H
        INT 21H
        CALL PRINT16  
        
        JMP ASK_USER
        
    PROGRAM3:
        LEA DX, MSG1
        MOV AH, 09H
        INT 21H
        
        XOR AX, AX
        CALL ACCEPT
        MOV AL, BL
        AND AL, 0FH ; MASK 4 LSB
        MOV BL, AL
        
        LEA DX, OP3
        MOV AH, 09H
        INT 21H
        CALL PRINT 
        
        JMP ASK_USER
        
    PROGRAM4:
        LEA DX, MSG1
        MOV AH, 09H
        INT 21H
        
        XOR AX, AX
        CALL ACCEPT
        MOV AL, BL
        AND AL, 0F0H ; MASK 4 MSB
        MOV BL, AL
        
        LEA DX, OP3
        MOV AH, 09H
        INT 21H
        CALL PRINT  
        
        JMP ASK_USER
    PROGRAM5:
        LEA DX, MSG2
        MOV AH, 09H
        INT 21H
        
        XOR AX, AX
        CALL ACCEPT16
        MOV AX, BX
        AND AX, 00FFH ; MASK 8 LSB
        MOV BX, AX
        
        LEA DX, OP4
        MOV AH, 09H
        INT 21H
        CALL PRINT16 
        
        JMP ASK_USER
                    
    PROGRAM6: 
        LEA DX, MSG2
        MOV AH, 09H
        INT 21H
        
        XOR AX, AX
        CALL ACCEPT16
        MOV AX, BX
        AND AX, 0FF00H ; MASK 8 MSB
        MOV BX, AX
        
        LEA DX, OP4
        MOV AH, 09H
        INT 21H
        CALL PRINT16 
        
        JMP ASK_USER
     
    PROGRAM7: 
        LEA DX, MSG1
        MOV AH, 09H
        INT 21H
        
        CALL ACCEPT
        MOV AL, BL   
        
        ; to shift number by
        LEA DX, MSG4
        MOV AH, 09H
        INT 21H
        
        CALL ACCEPT     
        MOV CL, BL       
       
        SHL AL, CL       
        MOV BL, AL    
        
        LEA DX, OP5
        MOV AH, 09H
        INT 21H
        CALL PRINT
        
        JMP ASK_USER

    PROGRAM8: 
        LEA DX, MSG1
        MOV AH, 09H
        INT 21H
        
        CALL ACCEPT
        MOV AL, BL   
        
        ; to shift number by
        LEA DX, MSG4
        MOV AH, 09H
        INT 21H
        
        CALL ACCEPT     
        MOV CL, BL       
       
        SHR AL, CL       
        MOV BL, AL    
        
        LEA DX, OP5
        MOV AH, 09H
        INT 21H
        CALL PRINT
        
        JMP ASK_USER   
        
        
    PROGRAM9:
        LEA DX, MSG2
        MOV AH, 09H
        INT 21H
        
        CALL ACCEPT16 
        PUSH BX    
        
        LEA DX, MSG4
        MOV AH, 09H
        INT 21H
        
        CALL ACCEPT   
        MOV CL, BL 
        POP AX    
        
        SHL AX, CL     
        MOV BX, AX 
        
        LEA DX, OP5
        MOV AH, 09H
        INT 21H
        CALL PRINT16
        
        JMP ASK_USER   
        
        
    PROGRAM10:
        LEA DX, MSG2
        MOV AH, 09H
        INT 21H
        
        CALL ACCEPT16 
        PUSH BX    
        
        LEA DX, MSG4
        MOV AH, 09H
        INT 21H
        
        CALL ACCEPT   
        MOV CL, BL 
        POP AX    
        
        SHR AX, CL     
        MOV BX, AX 
        
        LEA DX, OP5
        MOV AH, 09H
        INT 21H
        CALL PRINT16
        
        JMP ASK_USER   
        
        
    PROGRAM11: 
        LEA DX, MSG5
        MOV AH, 09H
        INT 21H
        
        MOV AH, 01H    
        INT 21H
        SUB AL, 48
        MOV OPR, AL  
        
        MOV AL, OPR
        CMP AL, 1
        JE EVENODD8
        CMP AL, 2
        JE EVENODD16
        JMP EXIT
        
        EVENODD16:
            LEA DX, MSG2
            MOV AH, 09H
            INT 21H
            
            CALL ACCEPT16
            MOV AX, BX
            
            MOV AH, 01H
            TEST AX, 0001H ; CHECK IF BIT SET TO ZERO
            JNZ ODD16
            
            ; EVEN MSG
            LEA DX, MSG6
            MOV AH, 09H
            INT 21H   
            
            JMP ASK_USER
            
            ODD16:
                ; ODD MSG
                LEA DX, MSG7
                MOV AH, 09H
                INT 21H
                
                JMP ASK_USER   
            
        EVENODD8:
            LEA DX, MSG1
            MOV AH, 09H
            INT 21H
            
            CALL ACCEPT
            MOV AL, BL
            
            MOV AH, 0H
            MOV BL, 2
            DIV BL
            
            CMP AH, 0
            JNZ ODD8
            
            ; PRINT NEWLINE
            MOV AH, 02H
            MOV DL, 13
            INT 21H
            MOV AH, 02H
            MOV DL, 10
            INT 21H
            
            ; EVEN MSG
            LEA DX, MSG6
            MOV AH, 09H
            INT 21H
            
            JMP ASK_USER
            
            ODD8:
                ; PRINT NEWLINE
                MOV AH, 02H
                MOV DL, 13
                INT 21H
                MOV AH, 02
                MOV AL, 10
                INT 21H
                
                
                ; ODD MSG
                LEA DX, MSG7
                MOV AH, 09H
                INT 21H
                
                JMP ASK_USER   
                
                
    
        
    ASK_USER:
        ; ASK USER TO CONTINUE OR NOT
        LEA DX, MSG3
        MOV AH, 09H
        INT 21H
        
        MOV AH, 01H
        INT 21H
        SUB AL, 48
        MOV OPR, AL 
        
        MOV AL, OPR
        CMP AL, 1
        JE CONTINUE
        JMP EXIT   
        
    EXIT:
        MOV AH, 4CH
        INT 21H
        
MAIN ENDP

; 8 BIT ACCEPT PROCEDURE
ACCEPT PROC
    MOV CH, 02H
    MOV CL, 04H
    MOV BL, 00H
BACK:
    SHL BL, CL
    MOV AH, 01H
    INT 21H
    CMP AL, 41H
    JC L2
    SUB AL, 07H
L2:
    SUB AL, 30H   
    ADD BL, AL 
    DEC CH
    JNZ BACK
    RET
ACCEPT ENDP

; 8 BIT PRINT PROCEDURE
PRINT PROC
    MOV CH, 02H
    MOV CL, 04H
BA:
    ROL BL, CL
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 0AH
    JC L1 
    ADD DL, 07H
L1:
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC CH
    JNZ BA
    RET
PRINT ENDP

; 16 BIT ACCEPT PROCEDURE
ACCEPT16 PROC
    MOV CH, 04H
    MOV CL, 04H
    MOV BX, 0000H
BACK16:
    SHL BX, CL
    MOV AH, 01H
    INT 21H
    CMP AL, 41H
    JC L2_16
    SUB AL, 07H
L2_16:
    SUB AL, 30H
    ADD BL, AL
    DEC CH
    JNZ BACK16
    RET
ACCEPT16 ENDP

; 16 BIT DISPLAY PROCEDURE
PRINT16 PROC 
    MOV CH, 04H
    MOV CL, 04H
BA16: 
    ROL BX, CL    
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
