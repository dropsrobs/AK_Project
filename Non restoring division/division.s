NUM_SIZE = 64
MEM_SIZE = 8
.bss
    .lcomm quotient, MEM_SIZE
    .lcomm mantissa, MEM_SIZE
    .lcomm remainder, MEM_SIZE
    .lcomm loop_size, 4
    .lcomm last_popped, 4
.text
.globl division
.type division, @function

division:
    push %ebp
    movl %esp, %ebp

    movl $loop_size, %eax        #loop_size address
    push %eax
    mov $NUM_SIZE, %eax         #NUM_SIZE value
    push %eax
    call set_loop_size          #initialize loop_size

###############################copy dividend to quotient

    movl loop_size, %eax
    push %eax
    movl 8(%ebp), %eax          #source address
    push %eax
    movl $quotient, %eax        #destination address
    push %eax

    call copy

##############################copy divisor to mantissa

    movl loop_size, %eax
    push %eax
    movl 12(%ebp), %eax
    push %eax
    movl $mantissa, %eax
    push %eax

    call copy

    movl $NUM_SIZE, %ecx

main_loop:
#############################shifter
    movl loop_size, %eax
    push %eax
    movl $last_popped, %eax
    push %eax
    movl $remainder, %eax
    push %eax
    movl $quotient, %eax
    push %eax

    call shifter

    movl last_popped, %eax
    cmp $1, %eax
    je mantissa_addition
    jmp mantissa_subtraction

mantissa_addition:
    movl loop_size, %eax
    push %eax
    movl $remainder, %eax
    push %eax
    movl $mantissa, %eax
    push %eax

    call addition
    jmp mantissa_continue

mantissa_subtraction:
    movl loop_size, %eax
    push %eax
    movl $remainder, %eax
    push %eax
    movl $mantissa, %eax
    push %eax

    call subtraction

mantissa_continue:
    movl loop_size, %eax
    push %eax
    movl $remainder, %eax
    push %eax
    movl $quotient, %eax
    push %eax

    call reverter

    dec %ecx
    cmp $0, %ecx
    jne main_loop

    xor %edi, %edi
    movl remainder(,%edi, 4), %eax
    and $0x80000000, %eax
    cmp $0x80000000, %eax
    je divisor_addition
    jmp divisor_continue

divisor_addition:
    movl loop_size, %eax
    push %eax
    movl $remainder, %eax
    push %eax
    movl $mantissa, %eax
    push %eax

    call addition

divisor_continue:

    movl loop_size, %eax
    push %eax
    movl $quotient, %eax
    push %eax
    movl 16(%ebp), %eax
    push %eax

    call copy

    movl loop_size, %eax
    push %eax
    movl $remainder, %eax
    push %eax
    movl 20(%ebp), %eax
    push %eax

    call copy

    leave
ret