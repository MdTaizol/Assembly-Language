; Level 4 - BIOS Interrupts
; Reads a key directly using BIOS int 16h instead of DOS int 21h

.model small
.stack 100h

.data
    msg db 'Press any key...$'
    msg2 db 0dh, 0ah, 'You pressed a key!$'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    lea dx, msg
    int 21h

    mov ah, 00h            ; BIOS function: wait for keypress
    int 16h                 ; BIOS keyboard interrupt (returns key in AL/AH)

    mov ah, 09h
    lea dx, msg2
    int 21h

    mov ah, 4ch
    int 21h
main endp
end main
