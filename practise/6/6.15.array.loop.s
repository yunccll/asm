.section .data
fmt_nag:    
    .asciz "nag int\n"
fmt_pos:    
    .asciz "pos int\n"

fmt_sum:
    .asciz "sum of byte_tbl is %u\n"
byte_tbl:
    .byte 11, 10, 10, 10, 8

.section .text
.type p_6_15 @function
.globl p_6_15
p_6_15:
    pushl %ebp
    movl %esp, %ebp

    subl $16, %esp # 4*dword


    # 1. test code for js ==> SF=1 jmp
    movl $-12, %eax
    subl $0,%eax
    js show_neg
    movl $fmt_pos, (%esp)
    call printf
    jmp then
show_neg:
    movl $fmt_nag, (%esp)
    call printf

then:

    #6.15 sum the byte_tbl  with loop(CX)
    movl $0, %eax
    movl $5, %ecx
    movl $byte_tbl-1, %ebx
    #leal byte_tbl, %ebx
    #dec  %ebx
lc1:
    addb (%ebx,%ecx,1), %al
    loop lc1

    movl $fmt_sum, (%esp)
    movl %eax, 4(%esp)
    call printf



    #6.15 sum the byte_tbl with normal cmp-jump 
    xor %ecx, %ecx
    movl $5, %ebx  # count
    movl $byte_tbl-1, %eax
lc2:
    addb (%ebx, %eax, 1), %cl
    dec %ebx
    cmpl $0, %ebx
    ja lc2

    movl $fmt_sum, (%esp)
    movl %ecx, 4(%esp)
    call printf

    addl $16, %esp
    
    movl %ebp, %esp
    popl %ebp
    
    ret
