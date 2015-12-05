.bss
    .lcomm MSB_holder_old, 4
    .lcomm MSB_holder_new, 4
.text
.globl shifter
.type shifter, @function
shifter:
    push %ebp
    movl %esp, %ebp

    push %eax
    push %esi
    push %edi
    push %edx
    push %ecx

    movl 8(%ebp), %eax #quotient address
    movl 12(%ebp), %ebx #remainder address
    movl 16(%ebp), %edx #last_popped address
    movl 20(%ebp), %ecx #loop_size

###################last_popped retrieval
    xor %edi, %edi
    movl (%ebx, %edi, 4), %esi
    xor %edi, %edi
    and $0x80000000, %esi
    cmp $0x80000000, %esi
    je set_last_popped_to_one
    jmp last_popped_continue

set_last_popped_to_one:
    inc %edi

last_popped_continue:
    movl %esi, (%edx)    #store last_popped in given address

    movl %ecx, %edi
    dec %edi             #start from LSB

second_operand_loop:

    movl (%eax, %edi, 4), %edx
    and $0x80000000, %edx        #check MSB
    cmp $0x80000000, %edx
    je set_MSB_new_to_one_second
    jmp MSB_new_continue_second

set_MSB_new_to_one_second:
    movl $1, %edx

MSB_new_continue_second:
    movl %edx, MSB_holder_new
    movl (%eax, %edi, 4), %edx
    shl %edx
    add MSB_holder_old, %edx
    movl %edx, (%eax, %edi, 4)

    movl MSB_holder_new, %edx       #exchange values
    movl MSB_holder_old, %esi
    movl %edx, MSB_holder_old
    movl %esi, MSB_holder_new

    dec %edi

    loop second_operand_loop

    movl 20(%ebp), %ecx  #loop_size
    movl %ecx, %edi
    dec %edi             #start from LSB

first_operand_loop:
    movl (%eax, %edi, 4), %edx
    and $0x80000000, %edx        #check MSB
    cmp $0x80000000, %edx
    je set_MSB_new_to_one_first
    jmp MSB_new_continue_first

set_MSB_new_to_one_first:
    movl $1, %edx

MSB_new_continue_first:
    movl %edx, MSB_holder_new
    movl (%eax, %edi, 4), %edx
    shl %edx
    add MSB_holder_old, %edx
    movl %edx, (%eax, %edi, 4)

    movl MSB_holder_new, %edx       #exchange values
    movl MSB_holder_old, %esi
    movl %edx, MSB_holder_old
    movl %esi, MSB_holder_new

    dec %edi

    loop first_operand_loop

    pop %ecx
    pop %edx
    pop %edi
    pop %esi
    pop %eax

    leave
ret
