; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h                    ; ORiGin - Program starts at memory address 100h (DOS .COM format)

; =================== SHIFT LEFT OPERATIONS ===================
MOV AL,02H                  ; Move 02h (2 decimal) into AL register
                           ; AL = 00000010 (binary)
                           
SHL AL,01H                  ; Shift Left by 1 bit (multiply by 2^1 = 2)
                           ; AL = 00000100 (4 decimal)
                           ; Result: 2 × 2 = 4

MOV CL,02H                  ; Move 02h into CL (shift counter)
SHL AL,CL                   ; Shift Left by CL bits (2 bits)
                           ; AL was 4: 00000100 ? 00010000 (16 decimal)
                           ; Result: 4 × 2² = 16

; =================== SHIFT RIGHT OPERATIONS ===================
MOV AL,08H                  ; Move 08h (8 decimal) into AL
                           ; AL = 00001000 (binary)
                           
SHR AL,01H                  ; Shift Right by 1 bit (divide by 2)
                           ; AL = 00000100 (4 decimal)
                           ; Result: 8 ÷ 2 = 4

MOV CL,02H                  ; Move 02h into CL
SHR AL,CL                   ; Shift Right by CL bits (2 bits)
                           ; AL was 4: 00000100 ? 00000001 (1 decimal)
                           ; Result: 4 ÷ 2² = 1

; =================== ARITHMETIC RIGHT SHIFT ===================
;SAR (Shift Arithmetic Right - preserves sign bit)
MOV AL,88H                  ; Move 88h (136 decimal, -120 in signed) into AL
                           ; AL = 10001000 (negative number in 2's complement)
                           
SAR AL,01H                  ; Arithmetic Right Shift by 1 (preserves sign)
                           ; AL = 11000100 (sign bit 1 fills from left)
                           ; Result: -120 ÷ 2 = -60 (signed division)

; =================== ROTATE OPERATIONS ===================
MOV AL,80H                  ; Move 80h into AL
                           ; AL = 10000000 (binary)
                           
ROL AL,01H                  ; Rotate Left by 1 bit (circular shift)
                           ; AL = 00000001 (leftmost bit wraps to right)
                           ; Carry Flag = 1 (original leftmost bit)

MOV AL,01H                  ; Move 01h into AL  
                           ; AL = 00000001 (binary)
                           
ROR AL,01H                  ; Rotate Right by 1 bit (circular shift)
                           ; AL = 10000000 (rightmost bit wraps to left)
                           ; Carry Flag = 1 (original rightmost bit)

; =================== ROTATE THROUGH CARRY ===================
STC                         ; Set Carry Flag to 1
                           ; Carry Flag = 1

MOV AL,10H                  ; Move 10h into AL
                           ; AL = 00010000, Carry = 1
                           
RCR AL,01H                  ; Rotate Right through Carry
                           ; Carry becomes leftmost bit, rightmost goes to carry
                           ; AL = 10001000, Carry = 0
                           ; (9-bit rotation: Carry + 8 bits of AL)

; =================== ARITHMETIC OPERATIONS ===================
MOV AL,55H                  ; Move 55h (85 decimal) into AL
                           ; AL = 01010101 (binary pattern)
                           
MOV BL,0AAH                 ; Move AAh (170 decimal) into BL
                           ; BL = 10101010 (binary pattern)
                           
ADD AL,BL                   ; Add BL to AL
                           ; AL = 55h + AAh = FFh (255 decimal)
                           ; Sets flags based on result

; =================== LOGICAL TEST OPERATION ===================
MOV AL,55H                  ; Move 55h into AL
                           ; AL = 01010101
                           
MOV BL,0AAH                 ; Move AAh into BL  
                           ; BL = 10101010
                           
TEST AL,BL                  ; Logical AND but doesn't store result
                           ; 01010101 AND 10101010 = 00000000
                           ; Sets Zero Flag = 1 (result is zero)
                           ; AL and BL remain unchanged

; =================== EXCLUSIVE OR OPERATIONS ===================
MOV AL,32H                  ; Move 32h into AL
                           ; AL = 00110010
                           
XOR AL,AL                   ; XOR AL with itself
                           ; Any number XOR with itself = 0
                           ; AL = 00000000 (common way to clear register)

; =================== LOGICAL OR OPERATION ===================
MOV AL,55H                  ; Move 55h into AL
                           ; AL = 01010101
                           
MOV BL,0AAH                 ; Move AAh into BL
                           ; BL = 10101010
                           
OR AL,BL                    ; Logical OR operation
                           ; 01010101 OR 10101010 = 11111111
                           ; AL = FFh (255 decimal)

; =================== NEGATION OPERATION ===================
MOV AL,0FFH                 ; Move FFh (255 decimal) into AL
                           ; AL = 11111111
                           
NEG AL                      ; Two's complement negation
                           ; NEG = NOT + 1 (flip bits and add 1)
                           ; NOT 11111111 = 00000000, then +1 = 00000001
                           ; AL = 01h (1 decimal)

HLT

;DB=define byte(will define one or more byte constants.for a given variable"defines one byte")
ret
; =================== SUMMARY OF RESULTS ===================
; Initial Operations:
; - SHL 2 by 1 bit = 4, then by 2 bits = 16
; - SHR 8 by 1 bit = 4, then by 2 bits = 1  
; - SAR 88h preserves sign bit during right shift
; - ROL 80h wraps leftmost bit to rightmost position
; - ROR 01h wraps rightmost bit to leftmost position
; - RCR includes carry flag in 9-bit rotation
; 
; Arithmetic & Logic:
; - ADD: 55h + AAh = FFh
; - TEST: 55h AND AAh = 0 (sets Zero Flag)
; - XOR AL,AL always results in 0 (clears register)
; - OR: 55h OR AAh = FFh
; - NEG: Two's complement of FFh = 01h
