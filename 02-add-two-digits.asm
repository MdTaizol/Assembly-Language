; Level 1 - Add two single-digit numbers
; Reads two digits from keyboard, adds them, prints result

.model small
.stack 100h

.data
    a db 'Enter the first number: $'
    b db 'Enter the second number: $'
    c db 'Result: $'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    lea dx, a
    int 21h
    mov ah, 01h          ; read a character
    int 21h
    mov bl, al           ; store first digit

    mov ah, 09h
    lea dx, b
    int 21h
    mov ah, 01h
    int 21h
    mov bh, al           ; store second digit

    mov ah, 09h
    lea dx, c
    int 21h

    add bl, bh           ; add the two ASCII digits
    sub bl, 48            ; adjust so result prints as a digit ('0' = 48)

    mov ah, 02h           ; print single character
    mov dl, bl
    int 21h

exit:
    mov ah, 4ch
    int 21h
main endp
end main
