section .text
    global _start

; int execve(const char *filename, char *const argv[], char *const envp[]);

; ebx = *filename
; ecx = **argv
; edx = **envp

_start:
    push 0x0068732f ; hs/
    push 0x6e69622f ; nib/
    mov  eax, esp ; save esp (stackpoint) in eax
    mov ebx, eax ; filename to execute
    mov ecx, 0 ; arguments
    mov edx, 0 ; envp
    mov eax, 0xb ; execve()
    int 0x80 ; make kernel execute the system call
