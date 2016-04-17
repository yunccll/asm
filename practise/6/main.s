.section .text
.global  _start
_start :
    pushl %ebp
    movl %esp, %ebp
    subl $16, %esp # 4*dword


    call p_6_8

    call p_6_15

    addl $16, %esp
    movl %ebp, %esp
    popl %ebp

    movl $1, %eax
    movl $0, %ebx
    int $0x80 # exit-1(0)
