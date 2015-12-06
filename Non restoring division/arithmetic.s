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
    clc

addition_loop:
    movl (%eax, %edi, 4), %edx
    movl (%ebx, %edi, 4), %esi
    adc %edx, %esi
    movl %esi, (%ebx, %edi, 4)
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
    clc

subtraction_loop:
    movl (%eax, %edi, 4), %edx
    movl (%ebx, %edi, 4), %esi
    sbb %edx, %esi
    movl %esi, (%ebx, %edi, 4)
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
    push %esi

    movl 8(%ebp), %eax #quotient
    movl 12(%ebp), %ebx #remainder
    movl 16(%ebp), %ecx #loop_size

    dec %ecx
    xor %edi, %edi

    movl (%ebx, %edi, 4), %edx
    and $0x80000000, %edx
    cmp $0x80000000, %edx
    je negate_one
    jmp negate_zero

negate_one:
    movl %ecx, %edi
    movl (%eax, %edi, 4), %edx
    and $0b11111111111111111111111111111110, %edx
    movl %edx, (%eax, %edi, 4)
    jmp continue

negate_zero:
    movl %ecx, %edi
    movl (%eax, %edi, 4), %edx
    or $0b00000000000000000000000000000001, %edx
    movl %edx, (%eax, %edi, 4)

continue:

    pop %esi
    pop %edx
    pop %ecx
    pop %ebx
    pop %eax

    leave
ret
