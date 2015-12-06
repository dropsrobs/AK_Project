.text
.globl addition
.type addition, @function
addition:
    push %ebp
    movl %esp, %ebp

    push %eax
    push %ebx
    push %ecx
    push %edx
    push %edi

    movl 8(%ebp), %eax #second_operand
    movl 12(%ebp), %ebx #remainder address
    movl 16(%ebp), %ecx #loop_size

    movl %ecx, %edi
    dec %edi

addition_loop:
    movl (%eax, %edi, 4), %edx
    movl (%ebx, %edi, 4), %esi
    adc %esi, %edx
    movl %edx, (%ebx, %edi, 4)
    dec %edi
    loop addition_loop

    pop %edi
    pop %edx
    pop %ecx
    pop %ebx
    pop %eax
    leave
ret

.globl subtraction
.type subtraction, @function
subtraction:
    push %ebp
    movl %esp, %ebp

    push %eax
    push %ebx
    push %ecx
    push %edx
    push %edi

    movl 8(%ebp), %eax #second_operand
    movl 12(%ebp), %ebx #remainder address
    movl 16(%ebp), %ecx #loop_size

    movl %ecx, %edi
    dec %edi

subtraction_loop:
    movl (%eax, %edi, 4), %edx
    movl (%ebx, %edi, 4), %esi
    sbb %esi, %edx
    movl %edx, (%ebx, %edi, 4)
    dec %edi
    loop subtraction_loop

    pop %edi
    pop %edx
    pop %ecx
    pop %ebx
    pop %eax
    leave
ret

.globl reverter
.type reverter, @function
reverter:
    push %ebp
    movl %esp, %ebp

    push %eax
    push %ebx
    push %ecx
    push %edx

    movl 8(%ebp), %eax #quotient
    movl 12(%ebp), %ebx #remainder
    movl 16(%ebp), %ecx #loop_size
    dec %ecx

    xor %edi, %edi

    movl (%ebx, %edi, 4), %edx
    and $0x80000000, %edx
    cmp $0x80000000, %edx
    je negate_one

#move to quotient
    movl %ecx, %edi
    movl (%eax, %edi, 4), %edx
    add $1, %edx
    movl %edx, (%eax, %edi, 4)

    jmp continue
negate_one:
    movl %ecx, %edi
    movl (%eax, %edi, 4), %edx
    sub $1, %edx
    movl %edx, (%eax, %edi, 4)

continue:

    pop %edx
    pop %ecx
    pop %ebx
    pop %eax
    
    leave
ret
