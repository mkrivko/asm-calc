# asm-calc
Assembler Calculator
# Simple Calculator in Assembly

This is a simple calculator program written in x86 Assembly (NASM) that performs basic operations: addition, subtraction, multiplication, and division. The program interacts with the user via the console.

## How to Build and Run

1. Install NASM and an x86 emulator (like DOSBox or run directly on an x86 machine).
2. Compile the code:
   ```bash
   nasm -f elf32 calculator.asm -o calculator.o
   ld -m elf_i386 calculator.o -o calculator
