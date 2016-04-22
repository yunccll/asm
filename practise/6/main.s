    .file "main.s"

    .global _start
    .type _start @function
_start:
    pushl %ebp 
    movl %esp, %ebp


    subl $16, %esp

    call p_6_8
    call p_6_15
    call p_7_5
    call p_11_2
    call p_mul_div

    


    add $16, %esp

    movl %ebp, %esp
    popl %ebp

    movl $1, %eax
    movl $0, %ebx
    int $0x80

