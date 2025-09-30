; Menu driven program

.MODEL SMALL
.STACK 100H
.DATA
MSG DB 10, 13, "Enter a choice (1-4):", 10, 13, "1. Find smallest number", 10, 13, "2. Find largest number", 10, 13, "3. Sort list in ascending order", 10, 13, "4. Sort list in descending order", 10, 13, "$"
MSG1 DB "Input array is: ", 10, 13, "$" 
MSG2 DB 10, 13, "Do you want to continue:", 10, 13, "1. YES",10, 13, "2. NO", 10, 13, "$"
SPACE DB " $"
NEWLINE DB 10, 13, "$"     
MSG3 DB 10, 13, "SMALLEST: $"
MSG4 DB 10, 13, "LARGEST: $" 
MSG5 DB 10, 13, "ASCENDING ORDER: $"
MSG6 DB 10, 13, "DESCENDING ORDER: $"
ARR DB 9, 3, 4, 2, 5, 6, 1, 8, 7
OPR DB 0
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
         
    ; FIRST PART
    ; PRINT ORIGINAL ARRAY
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    MOV SI, OFFSET ARR
    MOV CX, 9             

    LOOPARR:
        MOV BL, [SI]
        ADD BL, 48             
        MOV DL, BL
        MOV AH, 02H
        INT 21H
    
        LEA DX, SPACE
        MOV AH, 09H
        INT 21H
        
        INC SI             
        LOOP LOOPARR
        
        LEA DX, NEWLINE
        MOV AH, 09H
        INT 21H   

    CONTINUE:
    ; SECOND PART      
    LEA DX, MSG
    MOV AH, 09H
    INT 21H 
    
    MOV AH, 01H
    INT 21H
    SUB AL, 48
    MOV OPR, AL
    
    
    MOV AL, OPR
    CMP AL, 1
    JE SMALLEST
    CMP AL, 2
    JE LARGEST
    CMP AL, 3
    JE ASCENDING
    CMP AL, 4
    JE DESCENDING
    JMP EXIT
     
    ; SMALLEST ELEMENT LOGIC
    SMALLEST: 
        MOV SI, OFFSET ARR
        MOV CX, 9
        MOV BL, [SI]
        
        TRAVERSE1:
        CMP [SI], BL; CMP CURRENT WITH SMALLEST
        JLE SMALL ; JUMP IF CURR <= SMALLEST SO FAR
            
        COMPARE1: 
        INC SI
        LOOP TRAVERSE1
                      
        ; SMALLEST: 
        LEA DX, MSG3
        MOV AH, 09H    
        INT 21H        
        
        ADD BL, 48 ; CHARACTER TO DIGIT
        MOV DL, BL    
        MOV AH, 02H
        INT 21H    
        
        JMP ASK_USER
       
        SMALL:
        MOV BL, [SI]
        JMP COMPARE1
     
    LARGEST:
        MOV SI, OFFSET ARR
        MOV CX, 9
        MOV BL, [SI]
        
        TRAVERSE2:
        CMP [SI], BL 
        JGE LARGE
        
        COMPARE2:
        INC SI
        LOOP TRAVERSE2
        
        ; LARGEST:
        LEA DX, MSG4
        MOV AH, 09
        INT 21H
        
        ADD BL, 48
        MOV DL, BL
        MOV AH, 02H
        INT 21H
        
        JMP ASK_USER
        
        LARGE:
        MOV BL, [SI]
        JMP COMPARE2  
                     
    
    ASCENDING:
        MOV CX, 9
        DEC CX
        
        OUTERLOOP1:
        MOV BX, CX
        MOV SI, 0
        
        CMPLOOP1:
        MOV AL, ARR[SI]
        MOV DL, ARR[SI + 1]
        CMP AL, DL
        
        JC NOSWAP1
        
        ; ELSE SWAP ELEMENTS
        MOV ARR[SI], DL
        MOV ARR[SI+1], AL
        
        NOSWAP1:
        INC SI
        DEC BX
        JNZ CMPLOOP1
        
        LOOP OUTERLOOP1
                    
        MOV SI, OFFSET ARR
        MOV CX, 9
        
        
        LEA DX, MSG5
        MOV AH, 09
        INT 21H
        
        ; DISPLAY SORTED ARRAY
        DISPLAY_ARRAY1:
            MOV CX, 9
            MOV BX, OFFSET ARR
            
            OUTPUT:
            MOV DL, [BX]
            ADD DL, 48
            MOV AH, 02H
            INT 21H
            
            MOV DL, ' '
            MOV AH, 02H
            INT 21H
            
            INC BX
            LOOP OUTPUT 
            
        JMP ASK_USER 
        
    DESCENDING:
        MOV CX, 9
        DEC CX
        
        OUTERLOOP2:
        MOV BX, CX                                          
        MOV SI, 0
        
        CMPLOOP2:
        MOV AL, ARR[SI]
        MOV DL, ARR[SI+1]   
        
        CMP AL, DL
        JNC NOSWAP2 
        
        ; ELSE SWAP ELEMENT
        MOV ARR[SI], DL
        MOV ARR[SI+1], AL
        
        NOSWAP2:
        INC SI
        DEC BX
        JNZ CMPLOOP2
        
        LOOP OUTERLOOP2   
        
        LEA DX, MSG6
        MOV AH, 09H
        INT 21H
        
        ; DISPLAY ARRAY IN DESCENDING ORDER    
        DISPLAY_ARR2:
            MOV CX, 9
            MOV BX, OFFSET ARR
            
            OUTPUT2:
            MOV DL, [BX]
            ADD DL, 48
            MOV AH, 02H
            INT 21H
            
            MOV DL, ' '
            MOV AH, 02H
            INT 21H
            
            INC BX
            LOOP OUTPUT2 
           
    ASK_USER:
        ; ASK USER TO CONTINUE OR NOT
        LEA DX, MSG2
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
                      
        
    ; exit
    EXIT:
        MOV AH, 4CH
        INT 21H
    
MAIN ENDP
END MAIN
