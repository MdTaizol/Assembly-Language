; Level 4 - Macros
; Defines a reusable PRINT_STR macro to avoid repeating code

.model small
.stack 100h

PRINT_STR MACRO msg
    mov ah, 09h
    lea dx, msg
    int 21h
ENDM

.data
    m1 db 'Macros make code reusable.$'
    m2 db 'No need to repeat the same instructions!$'

.code
main proc
    mov ax, @data
    mov ds, ax

    PRINT_STR m1          ; macro expands to mov/lea/int here
    PRINT_STR m2

    mov ah, 4ch
    int 21h
main endp
end main
