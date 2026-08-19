; Level 1 - Hello World
; Prints a string on screen using DOS interrupt 21h, function 09h

.model small
.stack 100h

.data
    msg db 'Hello, Assembly World!$'   ; string must end with '$'

.code
main proc
    mov ax, @data
    mov ds, ax          ; set up data segment

    mov ah, 09h          ; DOS function: print string
    lea dx, msg          ; load address of string into DX
    int 21h               ; call DOS interrupt

    mov ah, 4ch           ; DOS function: terminate program
    int 21h
main endp
end main
