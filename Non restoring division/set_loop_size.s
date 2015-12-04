.globl set_loop_size
.type set_loop_size, @function #set loop size for N-bits operands.
set_loop_size:                 #For instance 128/32-bit register = 4 cycles.
    push %ebp
    movl %esp, %ebp

    push %eax
    push %ebx
    push %edi

    movl 8(%ebp), %eax      #NUM_SIZE value
    movl 12(%ebp), %ebx     #loop_size address

    xor %edi, %edi

    shr $5, %eax
    movl %eax, (%ebx)

    pop %edi
    pop %ebx
    pop %eax

    leave
ret