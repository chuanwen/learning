#!/bin/sh
program="${1%.*}"
cat macro.txt code.text code.data > ${program}.asm
rm -f code.text code.data
nasm -f elf ${program}.asm && gcc -m32 -o ${program} ${program}.o

