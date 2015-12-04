.text
.globl copy
.type copy, @function
copy:
    push %ebp
    movl %esp, %ebp

    push %eax
    push %edi
    push %edx
    push %ecx

    movl 8(%ebp), %eax          #destination address
    movl 12(%ebp), %ebx         #source address
    movl 16(%ebp), %ecx         #loop size

    xor %edi, %edi

copy_loop:

    movl (%ebx, %edi, 4), %edx
    movl %edx, (%eax, %edi, 4)
    inc %edi

    loop copy_loop

    pop %ecx
    pop %edx
    pop %edi
    pop %eax

    leave
ret
