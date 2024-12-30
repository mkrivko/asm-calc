
---

#### **calculator.asm**  

```asm
section .data
    prompt1 db "Enter first number: ", 0
    prompt2 db "Enter second number: ", 0
    prompt3 db "Choose operation (+, -, *, /): ", 0
    result_msg db "Result: ", 0
    newline db 0xA, 0

section .bss
    num1 resb 10
    num2 resb 10
    op resb 1
    result resb 10

section .text
    global _start

_start:
    ; Prompt for the first number
    mov edx, prompt1_len
    mov ecx, prompt1
    call print_string
    call read_input
    mov esi, num1
    call string_to_int
    mov ebx, eax ; store first number

    ; Prompt for the second number
    mov edx, prompt2_len
    mov ecx, prompt2
    call print_string
    call read_input
    mov esi, num2
    call string_to_int
    mov ecx, eax ; store second number

    ; Prompt for the operation
    mov edx, prompt3_len
    mov ecx, prompt3
    call print_string
    call read_char
    mov [op], al

    ; Perform the calculation
    cmp byte [op], '+'
    je add
    cmp byte [op], '-'
    je subtract
    cmp byte [op], '*'
    je multiply
    cmp byte [op], '/'
    je divide

    ; If invalid operator, exit
    jmp exit

add:
    add ebx, ecx
    jmp print_result

subtract:
    sub ebx, ecx
    jmp print_result

multiply:
    imul ebx, ecx
    jmp print_result

divide:
    xor edx, edx
    idiv ecx
    jmp print_result

print_result:
    mov edx, result_msg_len
    mov ecx, result_msg
    call print_string

    mov eax, ebx
    call int_to_string
    mov edx, eax
    mov ecx, result
    call print_string

    ; Exit program
exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80

; Helper Functions
print_string:
    mov eax, 4
    mov ebx, 1
    int 0x80
    ret

read_input:
    mov eax, 3
    mov ebx, 0
    mov edx, 10
    int 0x80
    ret

read_char:
    mov eax, 3
    mov ebx, 0
    mov ecx, op
    mov edx, 1
    int 0x80
    ret

string_to_int:
    xor eax, eax
    xor ebx, ebx
.convert_loop:
    movzx edx, byte [esi]
    cmp edx, 0xA
    je .done
    sub edx, '0'
    imul eax, 10
    add eax, edx
    inc esi
    jmp .convert_loop
.done:
    ret

int_to_string:
    xor edx, edx
    mov edi, result
    add edi, 9
    mov byte [edi], 0
.reverse_loop:
    xor edx, edx
    div ebx, 10
    add dl, '0'
    dec edi
    mov byte [edi], dl
    test ebx, ebx
    jnz .reverse_loop
    mov eax, edi
    ret
