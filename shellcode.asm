section .text
    global _start

; int execve(const char *filename, char *const argv[], char *const envp[]);

; ebx = *filename
; ecx = **argv
; edx = **envp

_start:
    xor  eax, eax ; mov eax, 0
    push eax ; terminate string
    push 0x68732f2f ; hs//
    push 0x6e69622f ; nib/
    mov  ebx, esp ; filename to execute
    xor  ecx, ecx ; argv
    xor  edx, edx ; envp
    mov  al, 0xb ; execve()
    int  0x80 ; go kernel go!
