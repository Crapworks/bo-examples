#!/bin/bash

noaslr:
	sudo bash -c 'echo 0 > /proc/sys/kernel/randomize_va_space'

aslr:
	sudo bash -c 'echo 2 > /proc/sys/kernel/randomize_va_space'

vuln: vuln.c
	gcc -g -m32 -z execstack -o vuln -fno-stack-protector vuln.c

preshell: preshellcode.asm
	nasm -f elf preshellcode.asm
	ld -m elf_i386 -o preshellcode preshellcode.o

shell: shellcode.asm
	nasm -f elf shellcode.asm
	ld -m elf_i386 -o shellcode shellcode.o

clean:
	rm -f vuln preshellcode.o preshellcode shellcode.o shellcode
