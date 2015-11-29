.bss
    .lcomm quotient, 256
    .lcomm mantissa, 256
    .lcomm remainder, 256
.text
.globl division
.type division, @function

division:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %eax
    pushl %eax
    movl  quotient, %eax
    pushl %eax

    call copy

    movl $7, %ecx
    xor %edi, %edi

main_loop:
    movl (%edx, %edi, 4), %eax
    inc %edi
    nop
    loop main_loop

    leave
ret

.type copy, @function
copy:
    pushl %ebp
    movl %esp, %ebp
    pushl %eax
    pushl %edi
    pushl %edx

    movl 8(%ebp), %eax
    movl 12(%ebp), %ebx

    movl (%ebx, %edi, 4), %edx
    movl %edx, (%eax, %edi, 4)

    pop %edx
    pop %edi
    pop %eax
    leave
ret
