# Assembly-Language  


A small collection of x86 (8086/DOS) assembly language programs, written for MASM/TASM-style assemblers and run under DOS or a DOS emulator (e.g., DOSBox).

## 📄 Contents

| File | Description |
|------|-------------|
| `assembly add.txt` | Prompts the user for two single-digit numbers, adds them using the `int 21h` DOS interrupt for I/O, and prints the result to the screen. |

All learning examples below live in the [`examples/`](examples) folder — one file per topic, numbered from beginner to advanced:

| # | File | Level | Topic |
|---|------|-------|-------|
| 01 | `examples/01-hello-world.asm` | 🟢 Level 1 | Print a string to the screen |
| 02 | `examples/02-add-two-digits.asm` | 🟢 Level 1 | Keyboard input + basic addition (same as `assembly add.txt`) |
| 03 | `examples/03-loops-and-jumps.asm` | 🟡 Level 2 | `LOOP`, counters, conditional jumps |
| 04 | `examples/04-compare-two-numbers.asm` | 🟡 Level 2 | `CMP`, flags, `JE`/`JG` |
| 05 | `examples/05-procedures.asm` | 🟠 Level 3 | `PROC`, `CALL`, `RET` |
| 06 | `examples/06-string-reverse.asm` | 🟠 Level 3 | Arrays, `SI`/`DI` indexed addressing |
| 07 | `examples/07-bubble-sort.asm` | 🟠 Level 3 | Sorting an array |
| 08 | `examples/08-macros.asm` | 🔴 Level 4 | `MACRO` / `ENDM` |
| 09 | `examples/09-recursion-factorial.asm` | 🔴 Level 4 | Recursion using the stack |
| 10 | `examples/10-bios-keyboard.asm` | 🔴 Level 4 | BIOS interrupt `int 16h` |

## 🧠 About

This repository is meant to grow into a complete, beginner-to-advanced learning path for x86 (8086/DOS) assembly language. The idea is that anyone — from someone who has never touched assembly to someone brushing up on low-level concepts — can follow the topics below in order, write the matching program, and build real understanding step by step.

Currently included:

- Setting up a `.model small` memory model with `.stack` and `.data` segments
- Using DOS interrupt `int 21h` for console input/output
- Working with 8-bit registers (`al`, `bl`, `bh`)
- Basic arithmetic (`add`, `sub`) and ASCII digit conversion

## 🗺️ Learning Roadmap (Basic → Advanced)

Follow these stages in order. Each stage links to the kind of program you should try writing; add your own `.asm`/`.txt` file for each topic as you complete it (see [Suggested File Naming](#-suggested-file-naming) below).

### 🟢 Level 1 — Fundamentals
- What is assembly language? CPU, registers, memory basics
- Assembler directives: `.model`, `.stack`, `.data`, `.code`
- Registers: `AX`, `BX`, `CX`, `DX` and their 8-bit halves (`AH/AL`, etc.)
- `MOV` instruction and basic data movement
- DOS interrupts (`int 21h`) for input/output
- Printing a string to the screen
- Reading a character from the keyboard
- Simple single-digit addition/subtraction *(see `assembly add.txt`)*

**Code — printing a string** (`examples/01-hello-world.asm`):
```asm
.model small
.stack 100h
.data
    msg db 'Hello, Assembly World!$'
.code
main proc
    mov ax, @data
    mov ds, ax
    mov ah, 09h
    lea dx, msg
    int 21h
    mov ah, 4ch
    int 21h
main endp
end main
```

**Code — reading input & adding two digits** (`examples/02-add-two-digits.asm`):
```asm
mov ah, 01h          ; DOS function: read a character
int 21h
mov bl, al           ; store the digit typed
; ... repeat for a second digit into bh ...
add bl, bh
sub bl, 48           ; adjust ASCII digit before printing
mov ah, 02h
mov dl, bl
int 21h
```

### 🟡 Level 2 — Core Concepts
- Arithmetic instructions: `ADD`, `SUB`, `MUL`, `DIV`, `INC`, `DEC`
- Flags register and conditional flags (Zero, Carry, Sign, Overflow)
- Logical instructions: `AND`, `OR`, `XOR`, `NOT`
- Shift and rotate: `SHL`, `SHR`, `ROL`, `ROR`
- Comparison and jumps: `CMP`, `JMP`, `JE`, `JNE`, `JG`, `JL`
- Loops: `LOOP`, and building loops manually with jumps
- Working with the stack: `PUSH`, `POP`
- Multi-digit number input and output (converting ASCII ↔ numeric)

**Code — loop that counts 1 to 9** (`examples/03-loops-and-jumps.asm`):
```asm
mov cl, 9              ; loop counter
mov dl, '1'
print_loop:
    mov ah, 02h
    int 21h
    inc dl
    dec cl
    jnz print_loop       ; repeat while cl != 0
```

**Code — comparing two numbers** (`examples/04-compare-two-numbers.asm`):
```asm
mov al, num1
cmp al, num2
je equal
jg greater
; ... otherwise num2 is greater ...
```

### 🟠 Level 3 — Intermediate
- Procedures: `PROC`, `ENDP`, `CALL`, `RET`
- Passing parameters via registers, memory, and the stack
- Arrays and indexed addressing (`[BX]`, `[SI]`, `[DI]`)
- String instructions: `MOVSB`, `LODSB`, `STOSB`, `CMPSB`, `SCASB`
- String operations: length, copy, reverse, palindrome check
- Sorting arrays (bubble sort) in assembly
- Searching (linear search) in assembly
- Simple menu-driven programs using jump tables

**Code — a reusable procedure** (`examples/05-procedures.asm`):
```asm
print_newline proc
    mov ah, 02h
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h
    ret
print_newline endp
; call it anywhere with:  call print_newline
```

**Code — reversing a string with SI/DI** (`examples/06-string-reverse.asm`):
```asm
lea si, str1
add si, len - 1        ; SI -> last character
lea di, rev             ; DI -> output buffer
mov cx, len
copy_loop:
    mov al, [si]
    mov [di], al
    dec si
    inc di
    loop copy_loop
```

**Code — bubble sort** (`examples/07-bubble-sort.asm`):
```asm
inner_loop:
    mov al, [si]
    mov bl, [si + 1]
    cmp al, bl
    jle no_swap
    mov [si], bl        ; swap the two elements
    mov [si + 1], al
no_swap:
    inc si
    loop inner_loop
```

### 🔴 Level 4 — Advanced
- Macros: `MACRO`, `ENDM`, and writing reusable code blocks
- Recursion in assembly (simulating call stacks manually)
- Multiplication/division algorithms without `MUL`/`DIV`
- 2D arrays / matrix operations (addition, transpose)
- Interfacing with BIOS interrupts (`int 10h` for video, `int 16h` for keyboard)
- Simple graphics mode programming (pixel plotting via `int 10h`)
- Interrupt Service Routines (ISRs) and custom interrupts
- Basic file handling using DOS interrupts (open, read, write, close)

**Code — a macro** (`examples/08-macros.asm`):
```asm
PRINT_STR MACRO msg
    mov ah, 09h
    lea dx, msg
    int 21h
ENDM
; usage:  PRINT_STR m1
```

**Code — recursion (factorial)** (`examples/09-recursion-factorial.asm`):
```asm
factorial proc
    cmp al, 1
    jle base_case
    dec al
    push ax
    call factorial          ; recursive call
    pop bx
    inc bl
    mul bl
    ret
base_case:
    mov ax, 1
    ret
factorial endp
```

**Code — BIOS keyboard interrupt** (`examples/10-bios-keyboard.asm`):
```asm
mov ah, 00h        ; BIOS function: wait for keypress
int 16h             ; returns key code in AL/AH, no DOS needed
```

### 🟣 Level 5 — Expert / Systems-Level
- Segment:offset addressing and memory models in depth
- Writing Terminate-and-Stay-Resident (TSR) programs
- Linking assembly with C (calling conventions, inline ASM)
- Introduction to protected mode concepts (32-bit registers, `EAX`, etc.)
- Basic understanding of NASM/x86-64 syntax as a bridge to modern assembly
- Reverse engineering basics: reading disassembled code

> 💡 Tip: Don't rush the levels. Assembly rewards patience — trace through each program by hand (register by register) before running it, so you actually understand *why* it works.

## 📁 Suggested File Naming

As new topics are added, name files clearly so the roadmap and repo stay in sync, e.g.:

```
01-hello-world.asm
02-add-two-digits.asm
03-loops-and-jumps.asm
04-string-reverse.asm
05-array-sort.asm
```

### Example: `assembly add.txt`

This program:
1. Displays a prompt and reads a single character (digit) from the keyboard.
2. Repeats for a second digit.
3. Adds the two digits together, adjusts for ASCII encoding, and prints the resulting sum as a single character.

## ⚙️ Requirements

To assemble and run these programs you'll need one of the following:

- **[DOSBox](https://www.dosbox.com/)** — to emulate a DOS environment
- **TASM** (Turbo Assembler) or **MASM** (Microsoft Macro Assembler)

## 🚀 How to Run

1. Install [DOSBox](https://www.dosbox.com/) (or set up a DOS environment).
2. Mount the project folder and install TASM/MASM inside DOSBox.
3. Assemble and link the source file:
   ```
   tasm "assembly add.txt"
   tlink "assembly add"
   ```
4. Run the compiled executable:
   ```
   "assembly add"
   ```

## 📝 Notes

- The program uses `int 21h` function `01h` for character input and function `09h` for string output.
- The addition logic subtracts `48` (ASCII offset for `'0'`) so results are printed correctly as a single ASCII digit — meant for adding single-digit numbers only.

## 🤝 Contributing

Contributions are welcome! If you'd like to help build out this learning path:

1. Pick an unfilled topic from the [Learning Roadmap](#️-learning-roadmap-basic--advanced).
2. Write a well-commented `.asm` program for it.
3. Follow the [suggested file naming](#-suggested-file-naming) convention.
4. Open a pull request — add a short description of what the program does and which level it belongs to.

Beginners are especially encouraged to contribute Level 1–2 programs, since simple, clearly explained examples help others learning the language the most.

## 📜 License

No license specified yet. Consider adding one (e.g., MIT) if you'd like others to freely use and modify this code.
