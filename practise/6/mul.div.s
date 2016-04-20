    .section  .data
    base:
    .long 0x32

    .section  .rodata
    mul_result:
       .asciz "mul result is dx:0x%x, ax:0x%x\n" 
    div_result:
       .asciz "div result is ax:0x%x\n" 


    .text
    .global p_mul_div
    .type p_mul_div @function
p_mul_div:
    pushl %ebp
    movl %esp, %ebp
    subl $32, %esp

    movl base, %eax    
    movl $2, %ebx
    mul %ebx

    movl $mul_result, (%esp)
    movl %edx, 4(%esp)
    movl %eax, 8(%esp)
    call printf


    
    movl base, %eax    
    movl $2000000000, %ebx
    mull %ebx

    movl $mul_result, (%esp)
    movl %edx, 4(%esp)
    movl %eax, 8(%esp)
    call printf


    movl $0x20, %eax
    movw $2, %bx
    divw %bx

    movl $div_result, (%esp)
    movl %eax, 4(%esp)
    call printf

    addl $32, %esp
    movl %ebp, %esp
    popl %ebp
    ret
