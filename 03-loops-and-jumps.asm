; Level 2 - Loops and Jumps
; Prints the digits 1 to 9 using the LOOP instruction

.model small
.stack 100h

.data
    msg db 'Counting 1 to 9: $'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    lea dx, msg
    int 21h

    mov cl, 9             ; loop counter = 9
    mov dl, '1'            ; starting digit character

print_loop:
    mov ah, 02h            ; print one character
    int 21h
    inc dl                 ; move to next digit character
    dec cl                 ; decrease counter
    jnz print_loop          ; jump back if cl != 0

    mov ah, 4ch
    int 21h
main endp
end main
