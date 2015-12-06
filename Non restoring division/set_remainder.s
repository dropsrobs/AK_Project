.globl set_remainder
.type set_remainder, @function
set_remainder:
    push %ebp
    movl %esp, %ebp

    push %eax
    push %ebx
    push %ecx
    push %edi

    movl 8(%ebp), %eax      #remainder
    movl 12(%ebp), %ecx     #loop_size

    xor %edi, %edi
    xor %ebx, %ebx

remainder_loop:

    movl %ebx, (%eax, %edi, 4)
    inc %edi

    loop remainder_loop

    pop %edi
    pop %ecx
    pop %ebx
    pop %eax

    leave
ret