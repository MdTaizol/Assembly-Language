; Level 3 - Reverse a string using indexed addressing (SI/DI)

.model small
.stack 100h

.data
    str1 db 'HELLO$'
    len  equ $ - str1 - 1   ; length of string (excluding '$')
    rev  db 6 dup('$')       ; buffer for reversed string, +1 for '$'

.code
main proc
    mov ax, @data
    mov ds, ax

    lea si, str1
    add si, len - 1        ; SI points to last character of str1
    lea di, rev             ; DI points to start of reverse buffer

    mov cx, len
copy_loop:
    mov al, [si]
    mov [di], al
    dec si
    inc di
    loop copy_loop

    mov byte ptr [di], '$'   ; terminate the reversed string

    mov ah, 09h
    lea dx, rev
    int 21h

    mov ah, 4ch
    int 21h
main endp
end main
