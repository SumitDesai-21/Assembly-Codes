; Q.1 Find the length of a string and Reverse a string  
; length of string
.MODEL SMALL
.STACK 100h
.DATA
    string DB 'COEP123', '$'
.CODE
    MOV AX, @DATA
    MOV DS, AX
    
    MOV CX, 0
    LEA SI, string
    
    NEXT:
        MOV AL, [SI]
        CMP AL, '$'
        JZ DONE
        INC CX
        INC SI
        JMP NEXT
    DONE:
        END
    ;CX contains the length of the string    


; reverse a string
.MODEL SMALL
.STACK 100h
.DATA
    string DB 'microprocessor', '$'
.CODE
    MOV AX, @DATA
    MOV DS, AX
    
    MOV CX, 0
    LEA SI, string

    NEXT:
        MOV AL, [SI]
        CMP AL, '$'
        JZ HERE
        INC CX
        INC SI
        JMP NEXT
    HERE:
        LEA SI, string
        MOV DI, SI
        ADD DI, CX
        DEC DI
        
    REVERSE:
        MOV AL, [SI]
        MOV BL, [DI]
        MOV [SI], BL
        MOV [DI], AL
        
        CMP SI, DI
        JAE DONE
        
        INC SI
        DEC DI
        JMP REVERSE
        
    DONE:
        MOV DX, offset string
        MOV AH, 09h
        INT 21h
        
    END   


; Q.2 Concatenate two strings and Compare two strings
; concatenate two strings
.MODEL SMALL
.STACK 100h
.DATA
    str1 DB 'COEP', '$', 0, 0, 0, 0, 0   ; Extra space for str2
    str2 DB '123', '$'
.CODE
    MOV AX, @DATA
    MOV DS, AX    
    LEA SI, str1
    LEA DI, str2

    LENGTH:
        MOV AL, [SI]
        CMP AL, '$'
        JE COPY
        INC SI
        JMP LENGTH
    
    COPY:
        MOV AL,[DI]
        CMP AL, '$'
        JE DONE
        MOV [SI], AL
        INC SI
        INC DI
        JMP COPY
        
    DONE:
        MOV BYTE PTR [SI], '$'
        MOV AH, 09H
        MOV DX, OFFSET str1
        INT 21H    
    END    
    
; compare strings
.MODEL SMALL
.STACK 100h
.DATA
    str1 DB 'COEP$', 0
    str2 DB 'coep$', 0
    equal DB 'Equal$'
    notequal DB 'Not Equal$'

.CODE
    MOV AX, @DATA
    MOV DS, AX

    LEA SI, str1
    LEA DI, str2

    COMPARE:
        MOV AL, [SI]
        MOV BL, [DI]
        CMP AL, '$'
        JE END_CHECK
        CMP BL, '$'
        JE END_CHECK
        CMP AL, BL
        JNE NOT_EQUAL
        INC SI
        INC DI
        JMP COMPARE

    END_CHECK:
        CMP AL, BL
        JNE NOT_EQUAL

        MOV DX, OFFSET equal
        MOV AH, 09h
        INT 21h
        JMP HERE

    NOT_EQUAL:
        MOV DX, OFFSET notequal
        MOV AH, 09h
        INT 21h
    
    HERE:
        END

; Q.3 Search a string for a given substring

.MODEL SMALL
.STACK 100h
.DATA
    mainStr DB 'acars$', '$'
    subStr  DB 'car$', '$'
    founds   DB 'FOUND$', '$'
    notfound DB 'NOT FOUND$', '$'

.CODE
    MOV AX, @DATA
    MOV DS, AX

    LEA SI, mainStr

    SEARCH:
        MOV DI, SI
        LEA BX, subStr

    COMPARE:
        MOV AL, [DI]
        MOV DL, [BX]
        CMP DL, '$'
        JE FOUND
        CMP AL, '$'
        JE NOT_FOUND
        CMP AL, DL
        JNE NEXT_CHAR
        INC DI
        INC BX
        JMP COMPARE

    NEXT_CHAR:
        INC SI
        MOV AL, [SI]
        CMP AL, '$'
        JE NOT_FOUND
        JMP SEARCH

    FOUND:
        MOV DX, OFFSET founds
        MOV AH, 09h
        INT 21h
        JMP EXIT

    NOT_FOUND:
        MOV DX, OFFSET notfound
        MOV AH, 09h
        INT 21h

    EXIT:
        END

Q.4 Change the case of the string
;converts into lower case
.MODEL SMALL 
.STACK 100h
.DATA
    string DB 'HeLlOcOEp', '$'
.CODE
    MOV AX, @DATA
    MOV DS, AX
    
    LEA SI, string
    
    CHANGE:
        MOV AL, [SI]
        CMP AL, '$' 
        JZ EXIT
        CMP AL, 'a'
        JAE HERE
        
        ADD AL, 32
        MOV [SI], AL
        INC SI
        JMP CHANGE
        
        HERE:
        INC SI
        JMP CHANGE
                
    EXIT:
        MOV DX, OFFSET string
        MOV AH, 09h
        INT 21h
        END

; converts to uppercase 
.MODEL SMALL 
.STACK 100h
.DATA
    string DB 'HeLlOcOEp', '$'
.CODE
    MOV AX, @DATA
    MOV DS, AX
    
    LEA SI, string
    
    CHANGE:
        MOV AL, [SI]
        CMP AL, '$' 
        JZ EXIT
        CMP AL, 'Z'
        JLE HERE
        
        SUB AL, 32
        MOV [SI], AL
        INC SI
        JMP CHANGE
        
        HERE:
        INC SI
        JMP CHANGE
                
    EXIT:
        MOV DX, OFFSET string
        MOV AH, 09h
        INT 21h
        END


.MODEL SMALL
.STACK 100h
.DATA
    string DB 'COEP123$', 0

.CODE
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX           

    LEA SI, string        
    MOV DI, 2000h         

    COPY:
        MOV AL, [SI]
        CMP AL, '$'
        JE EXIT
        MOVSB                 
        JMP COPY

    EXIT:
        END 


;Q.5 Copy a string to a given location

.MODEL SMALL
.STACK 100h
.DATA
    string DB 'COEP123$', 0

.CODE
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX           

    LEA SI, string        
    MOV DI, 2000h         

    COPY:
        MOV AL, [SI]
        CMP AL, '$'
        JE EXIT
        MOVSB                 
        JMP COPY

    EXIT:
        END 

;Q.6 Check whether the given string is a palindrome
.MODEL SMALL
.STACK 100h
.DATA 
    string DB 'acars', '$'
    notp DB 'NOT PALINDROME$'
    p DB 'PALINDROME$'
    
.CODE
    MOV AX, @DATA
    MOV DS, AX
    
    LEA SI, string
    MOV CX, 0
    
    LENGTH:
        MOV AL, [SI]
        CMP AL, '$'
        JE DONE
        INC SI
        INC CX
        JMP LENGTH
    
    DONE: 
        MOV DI, SI
        DEC DI
    LEA SI, string
    
    MOV DL, 1    
    
    CHECK:
        CMP SI, DI
        JAE EXIT
        MOV AL, [SI]
        MOV BL, [DI]
        INC SI
        DEC DI
        CMP AL, BL
        JZ CHECK
        MOV DL, 0        
    
    EXIT: 
        CMP DL, 0
        JZ NOTPALIN
        
        MOV DX, OFFSET p
        MOV AH, 09h
        INT 21h
        JMP HERE:
    
    NOTPALIN:
        MOV DX, OFFSET notp
        MOV AH, 09h
        INT 21h
        
    HERE:
        END        


; Q.7 Write an ALP to find the number of occurrences of a string

.MODEL SMALL
.STACK 100H
.DATA
    text        DB 'programming$'
    target      DB 'r'
    count       DB 0
    msg1        DB 'Character: $'
    msg2        DB 13,10,'Count: $'
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA SI, text
    MOV BL, 0
    MOV DL, target
    CLD
    
COUNT_LOOP:
    LODSB
    CMP AL, '$'
    JE COUNT_DONE
    
    CMP AL, DL
    JNE COUNT_CONTINUE
    INC BL
    
COUNT_CONTINUE:
    JMP COUNT_LOOP
    
COUNT_DONE:
    MOV count, BL
    
    LEA DX, msg1
    MOV AH, 09H
    INT 21H
    
    MOV DL, target
    MOV AH, 02H
    INT 21H
    
    LEA DX, msg2
    MOV AH, 09H
    INT 21H
    
    MOV DL, count
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP
END MAIN
