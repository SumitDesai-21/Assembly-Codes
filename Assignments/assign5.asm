;Q.1
; Write an ALP to find ONE’S complement of 8 bit number and 16 bit number  
; we use NOT logical operator to find 1's compliment
org 100h              
; 1's compliment of 8 bit number 
MOV AL, 04H; ~0000 0100 == 1111 1011 == FB 
NOT AL ; FB   

; 1's compliment of 16 bit number 
MOV BX, 0AAAAH ; 1010 1010 1010 1010
NOT BX ; 0101 0101 0101 0101 == 5555H
HLT
ret


;Q.2
;Write an ALP to find TWO’S complement of 8 –bit number and 16 –bit number
org 100h
; 2's compliment of 8 bit number  
;#approach 1
;MOV AL, 04H ; 0000 0100  
;MOV BL, 00H ; 0000 0000 
;SUB BL, AL  ; 1111 1100 == FC  

; #approach 2
MOV AL,04
NEG AL

; 2's compliment of 16 bit number
; #approach 1
;MOV CX, 0001H
;MOV DX, 0000H
;SUB DX, CX ; FFFFH

; #approach 2
MOV CX, 0001H
NEG CX
HLT
ret


; Q.3
;MASKING LSB 4-BITS OF 8-BIT NUMBER, MASKING MSB 4-BITS OF 8-BIT NUMBER    
org 100h
; masking LSB 4bits
; clear upper 4 bits and keep lower 4 bits
MOV AL,0D6H  ; 1110 0110
AND AL, 0FH  ; 0000 1111 ; 1&1=1 else 0(clear)  

; masking MSB 4bits 
; clear lower 4 bits and keep upper 4 bits   
MOV BL, 0D6H ; 1110 0110
AND BL, 0F0H ; 1111 0000 ; D0
HLT
ret


;Q.4
; MASKING LSB 8-BITS OF A 16-BIT NUMBER, MASKING MSB 8-BITS OF A 16-BIT NUMBER
org 100h
;masking lsb 8 bits 
; clear upper 8 bits and keep lower 8 bits
MOV AX, 0AAAAH ; 1010 1010 1010 1010 
AND AX, 00FFH  ; 0000 0000 1111 1111

;masking msb 8 bits 
; clear lower 8 bits and keep upper 8 bits  
MOV BX, 0AAAAH ; 1010 1010 1010 1010 
AND BX, 0FF00H ; 1111 1111 0000 0000
ret

;Q.5
; SHIFT LEFT OF 8-BIT NUMBER, SHIFT RIGHT OF 8-BIT NUMBER
org 100h 
; shift left 
MOV AL, 01H
SHL AL, 02H

; shift right
MOV BL, 08H
SHR BL, 02H
HLT
ret

;Q.6
; SHIFT LEFT OF 16-BIT NUMBER, SHIFT RIGHT OF 16-BIT NUMBER
org 100h 
; shift left 
MOV AX, 5555H
SHR AX, 01H

; shift right
MOV BX, 0AAAAH
SHR BX, 01H
HLT
ret


; Q.7
; Check whether a number is even or odd
.model small
.stack 100h
.data 
    msg db "Enter a number: $"
    msg1 db "Given number is even$"
    msg2 db "Given number is odd$"
.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; display message
    mov ah, 9
    mov dx, offset msg
    int 21h  
    
    ; user input
    mov ah, 1
    int 21h  
    
   ; ASCII -> numeric
    sub al, 30h ; 30h => 48==0
    
    mov ah, 0
    mov bl, 2 ; Divisor
    div bl    ; AL = quotient & AH = remainder
    
    cmp ah, 0
    jnz odd
           
    ; Print newline
    mov ah, 02h
    mov dl, 13     
    int 21h
    mov ah, 02h
    mov dl, 10   
    int 21h
    
    ;even message
    mov ah, 9
    mov dx, offset msg1
    int 21h
    
    mov ah, 4ch
    int 21h
    
    odd:  
    ; Print newline 
    mov ah, 02h
    mov dl, 13     
    int 21h
    mov ah, 02h
    mov dl, 10     
    int 21h
    
    ;odd message
    mov ah, 9
    mov dx, offset msg2
    int 21h
    
    mov ah, 4ch
    int 21h
    
main endp
end main

; Q.8
.org 100h

start:
    mov ax, 3   
    mov bx, 3   
    call multiply
    ret

multiply:
    mov cx, ax   
    mov ax, 0      
    mov dx, 16   
    
loop1:
    rcr bx, 1  
    jnc skip        
    add ax, cx  
    
skip:
    rol cx, 1   
    dec dx       
    jnz loop1  
    
ret
