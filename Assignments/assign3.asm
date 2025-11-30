; Q1.Write an ALP to perform 8-bit multiplication
org 100h
MOV AL, 02H
MOV BL, 04H
MUL BL
HLT
ret          
                    
; Q.2 Write an ALP to perform 16-bit multiplication

org 100h
MOV AX, 2222H
MOV BX, 3333H
MUL BX
HLT
ret

;Q.3 Write an ALP to perform Division of 16 bit number by 8 bit number
org 100h

MOV AX, 0064H       
MOV BL, 05H         
DIV BL              
; Quotient is in AL & Remainder is in AH

HLT
ret

; Q.4 Write an ALP to perform Division of 32 bit number by 16 bit number
org 100h

MOV DX, 0001H       
MOV AX, 0000H         
                    
MOV CX, 0008H       
DIV CX   
; Quotient is in AX & Remainder is in DX

HLT    
ret

;Q.5 Finding the Fibonacci series of n terms
.model small
.stack 100h
.code
main proc
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV CL, AL ; counter
    MOV AX, 0000H ; prev
    MOV BX, 0001H ; curr
fib_loop:
    ADD AX, BX
    XCHG AX, BX 
    LOOP fib_loop
    HLT
main endp
end main

;Q.6 a Perform - (a + b) * (c + d)
MOV AX, 05H
MOV BX, 03H
MOV CX, 04H
MOV DX, 02H

ADD AX, BX
ADD CX, DX
MUL CX

HLT

;Q.6.b Perform - (a * b) + (c * d)
MOV AX, 05H
MOV BX, 03H
MOV CX, 04H
MOV DX, 02H

MUL BX
MOV BX, AX
MOV AX, CX
MUL DX
ADD AX, BX

HLT


;Q.7 Matrix addition and subtraction
MOV SI, 2000H
MOV DI, 2010H
MOV BX, 2020H
MOV CX, 4       ; 2x2 = 4 elements

addition:
    MOV AL, [SI]
    ADD AL, [DI]   ; addition (for subtraction use SUB AL,[DI])
    MOV [BX], AL
    INC SI
    INC DI
    INC BX
LOOP addition
HLT

;Q.8 Find Factorial of a Number Using Recursion
.model small
.stack 100h
.code

main proc
    MOV AX, 05H
    CALL FACTORIAL
    HLT
main endp

FACTORIAL proc
    CMP AX, 01H
    JLE BASE_CASE
    PUSH AX
    DEC AX
    CALL FACTORIAL
    POP BX
    MUL BX
    RET
BASE_CASE:
    MOV AX, 01H
    RET
FACTORIAL endp

end main

