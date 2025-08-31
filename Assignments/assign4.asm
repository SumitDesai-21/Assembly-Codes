; Array in assembly language
; header
include 'emu8086.inc'
.model small
.stack 100h
.data
    arr db 1, 2, 3, 4, 5
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        mov si, offset arr 
        mov cx, 5
        
        print "Array values: "
        loopArr:
            mov dl, [si]  
            add dl, 48 ; convert into number(48 == 0)
            mov ah, 02
            int 21h                                
            
            mov dl, 32 ; adds whitespaces
            int 21h                      
             
            inc si
        loop loopArr
    main endp
end main


; Q.1 Write an Assembly Language Program (ALP) to find the smallest and largest number from a given list
; smallest value
.model small
.stack 100h
.data
    arr db 9, 2, 8, 4, 5, 7
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        mov si, offset arr
        mov cx, 6
        mov bl, [si]
        
        loopArr:
        cmp [si], bl ; compare current value with smallest value
        jle small ; jump if curr value less than or equal to bl
                                                                    
        compare: 
        inc si
        loop loopArr
            
        add bl, 48 ; convert character to digit
        mov dl, bl
        mov ah, 2
        int 21h  
        HLT 
                                                                
        small:
        mov bl, [si]
        jmp compare ; jump at compare 
          
    main endp
end main
        
; largest value
.model small                                                                                              
.stack 100h
.data
    arr db 9, 2, 8, 4, 5, 7
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        mov si, offset arr
        mov cx, 6
        mov bl, [si]
        
        loopArr:
        cmp [si], bl ; compare current value with largest value
        jge large ; jump if curr value greater than or equal to bl
                                                                    
        compare:           
        inc si
        loop loopArr
            
        add bl, 48 ; convert character to digit
        mov dl, bl
        mov ah, 2
        int 21h  
        HLT 
                                                                
        large:
        mov bl, [si]
        jmp compare ; jump at compare 
          
    main endp
end main
        

;Q.2 Write an ALP to sort the numbers in Ascending and descending Order                                                          
; Ascending order 
.model small
.stack 100h

.data
    arr db 9, 5, 3, 2, 6, 1, 7, 8   
    msg db 'After sorting the array: $'
     
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov cx, 8
    dec cx             
    
    outerloop:
    mov bx, cx         
    mov si, 0         
    
    cmploop:
    mov al, arr[si]    
    mov dl, arr[si+1]
    cmp al, dl
    
    jc noSwap       ; jump if carry   ; Jump if current < next then no swap needed
    
    ; Swap elements
    mov arr[si], dl
    mov arr[si+1], al
    
    noSwap:
    inc si
    dec bx
    jnz cmploop        
    
    loop outerloop   
              
    ;to output a msg
    mov ah, 9
    mov dx, offset msg
    int 21h
    
    ; Display sorted array
    mov cx, 8
    mov bx, offset arr
    
    output:
    mov dl, [bx]
    add dl, 48  
    mov ah, 2
    int 21h
     
    mov dl, ' '
    mov ah, 2
    int 21h
    
    inc bx
    loop output
        
    ; Exit program
    mov ah, 4Ch
    int 21h
    
main endp
end main

; descending order
.model small
.stack 100h

.data
    arr db 9, 5, 3, 2, 6, 1, 7, 8   
    msg db 'After sorting the array: $'
     
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov cx, 8
    dec cx             
    
    outerloop:
    mov bx, cx         
    mov si, 0         
    
    cmploop:
    mov al, arr[si]    
    mov dl, arr[si+1]
    cmp al, dl
    
    jnc noSwap       ; jump if not carry   ; Jump if current > next then no swap needed
    
    ; Swap elements
    mov arr[si], dl
    mov arr[si+1], al
    
    noSwap:
    inc si
    dec bx
    jnz cmploop        
    
    loop outerloop   
              
    ;to output a msg
    mov ah, 9
    mov dx, offset msg
    int 21h
    
    ; Display sorted array
    mov cx, 8
    mov bx, offset arr
    
    output:
    mov dl, [bx]
    add dl, 48  
    mov ah, 2
    int 21h
     
    mov dl, ' '
    mov ah, 2
    int 21h
    
    inc bx
    loop output
        
    ; Exit program
    mov ah, 4Ch
    int 21h
    
main endp
end main
