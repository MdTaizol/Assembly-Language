; Level 2 - Compare two numbers using CMP and conditional jumps
; Compares two fixed numbers and prints which is larger

.model small
.stack 100h

.data
    num1 db 25
    num2 db 40
    msg1 db 'First number is greater$'
    msg2 db 'Second number is greater$'
    msg3 db 'Both numbers are equal$'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov al, num1
    cmp al, num2          ; compare num1 with num2
    je equal
    jg greater

    ; num2 is greater
    mov ah, 09h
    lea dx, msg2
    int 21h
    jmp exit

greater:
    mov ah, 09h
    lea dx, msg1
    int 21h
    jmp exit

equal:
    mov ah, 09h
    lea dx, msg3
    int 21h

exit:
    mov ah, 4ch
    int 21h
main endp
end main
