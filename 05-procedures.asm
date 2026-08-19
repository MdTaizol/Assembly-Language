; Level 3 - Procedures (CALL / RET)
; Uses a reusable procedure to print a newline, and another to print a message

.model small
.stack 100h

.data
    msg1 db 'This is line one.$'
    msg2 db 'This is line two.$'

.code

; --- Procedure: print_newline ---
; Prints a carriage return + line feed
print_newline proc
    mov ah, 02h
    mov dl, 0dh          ; carriage return
    int 21h
    mov dl, 0ah           ; line feed
    int 21h
    ret
print_newline endp

main proc
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    lea dx, msg1
    int 21h
    call print_newline    ; reuse the procedure

    mov ah, 09h
    lea dx, msg2
    int 21h
    call print_newline

    mov ah, 4ch
    int 21h
main endp
end main
