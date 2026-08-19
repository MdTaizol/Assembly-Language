; Level 3 - Bubble sort an array of bytes (ascending order)

.model small
.stack 100h

.data
    arr db 5, 3, 8, 1, 9, 2
    n   equ 6

.code
main proc
    mov ax, @data
    mov ds, ax

    mov cx, n - 1          ; outer loop counter
outer_loop:
    push cx
    lea si, arr
    mov cx, n - 1
inner_loop:
    mov al, [si]
    mov bl, [si + 1]
    cmp al, bl
    jle no_swap
    mov [si], bl           ; swap
    mov [si + 1], al
no_swap:
    inc si
    loop inner_loop
    pop cx
    loop outer_loop

    ; arr is now sorted in ascending order in memory

    mov ah, 4ch
    int 21h
main endp
end main
