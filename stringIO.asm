.model small
.stack 100
.data
msg db 'COEP$'         ; String ending with $ (DOS string terminator)
.code
mov ax, @data      ; Load data segment
mov ds, ax
mov dx, offset msg ; Load address of string into DX
mov ah, 09h        ; DOS function to display string
int 21h            ; Display the string
mov ah, 4ch        ; Exit program
int 21h

// alternate

.model small
.stack 100h
.data
str_disp db 'SUMIT','$'
.code
:
        mov ax,@data  
        mov ds,ax
        mov dx, offset str_disp
        mov ah, 09h
        int 21h

        mov ax, 4C00h
        int 21h
end 
