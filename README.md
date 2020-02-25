# Buffer Overflow Examples

Some code examples for playing around with buffer overflows and shellcode.

## Useful GDB commands

```
# show registers
info reg 

# disassemble functions
disassemble <function_name>

# using breakpoints

## show code for main function
list main

## break at line 10
break 10

## step to next line
s

## continue
c

## step to next instruction
si

# print address of variable
print &buff

# show overview of current stack frame
x/100x $sp-200

# always show next instruction
display/i $pc
```

## Extract shellcode from binary

```
for i in $(objdump -d shellcode |grep "^ " |cut -f2); do echo -n '\\x'$i; done; echo
```
