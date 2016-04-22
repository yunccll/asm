.section .data
fmt:
    .asciz "the eax is 0x%x, the word3 is 0x%x\n"
fmt_esi:
    .asciz "esi value 0x%x\n"

word3:
    .quad 0x23

rate_tbl:
    .quad 0x23, 0x34

byte_arr:
    .byte 0x12, 0x15, 0x16, 0x10, 0x08
    
    .section .text
    .global  p_6_9
    .type p_6_9 @function
p_6_9 :
    pushl %ebp
    movl %esp, %ebp

    subl $32, %esp #  alloc esp

    #  6.9 xchg instruction
    movl $0x64, %eax
    movl word3, %ebx

    movl $fmt, (%esp)
    movl %eax, 4(%esp)
    movl %ebx, 8(%esp)
    call printf

    movl 4(%esp), %eax
    xchgw word3, %ax
    movl  word3, %ebx

    movl $fmt, (%esp)
    movl %eax, 4(%esp)
    movl %ebx, 8(%esp)
    call printf

    #  6.10  lea instruction
    #leal rate_tbl, %esi # same as lea instruction 
    movl $rate_tbl, %esi 
    movl $fmt_esi, (%esp)
    movl %esi, 4(%esp)
    call printf

    leal 4(%esi), %esi # lead op1- any memory method -> 4(%esp)
    movl $fmt_esi, (%esp)
    movl %esi, 4(%esp)
    call printf

    addl $32, %esp  # free stack
    
    movl %ebp, %esp
    popl %ebp
    
    ret
