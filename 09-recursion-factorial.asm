; Level 4 - Recursion
; Calculates factorial of a number recursively using CALL/RET and the stack

.model small
.stack 100h

.data
    num db 5              ; calculate 5!
    result dw ?
    msg db 'Factorial calculated (see AX register).$'

.code

; --- Recursive procedure: factorial ---
; Input: AL = n
; Output: AX = n!
factorial proc
    cmp al, 1
    jle base_case
    dec al
    push ax               ; save (n-1) on the stack
    call factorial          ; recursive call: factorial(n-1)
    pop bx                 ; bl = original (n-1)
    inc bl                  ; bl = n
    mul bl                  ; ax = factorial(n-1) * n
    ret
base_case:
    mov ax, 1
    ret
factorial endp

main proc
    mov ax, @data
    mov ds, ax

    mov al, num
    call factorial          ; result ends up in AX

    mov ah, 09h
    lea dx, msg
    int 21h

    mov ah, 4ch
    int 21h
main endp
end main
