NUM_SIZE = 64
MEM_SIZE = 8
.bss
    .lcomm quotient, MEM_SIZE
    .lcomm mantissa, MEM_SIZE
    .lcomm remainder, MEM_SIZE
    .lcomm loop_size, 4
.text
.globl division
.type division, @function

division:
    push %ebp
    movl %esp, %ebp

    movl $loop_size, %eax        #loop_size address
    push %eax
    mov $NUM_SIZE, %eax
    push %eax                   #NUM_SIZE value
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

    movl loop_size, %ecx
    xor %edi, %edi
main_loop:

    

    loop main_loop

    leave
ret