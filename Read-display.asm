.model small
.stack 100
.data
.code 
    mov ax, @data
    mov ds, ax
    
    mov ah, 07h     ; Read character WITHOUT echo
    int 21h         ; Character stored in AL (not displayed)
        
    mov dl, al      ; Move character to DL
    mov ah, 02h     ; Display character function
    int 21h         ; Show character once
    
    mov ax, 4C00h   ; Exit program
    int 21h 
end
