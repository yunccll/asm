.section .text

fmt_fibo:
    .asciz "fibonacci is %u\n" 

.type p_7_5 @function
.global p_7_5
p_7_5:
    pushl %ebp
    movl %esp, %ebp
    subl $32, %esp
    
    movl $1, %eax
    movl %eax, -4(%ebp) #save eax
    movl $fmt_fibo, (%esp)
    movl %eax, 4(%esp)
    call printf

    
    movl $1, %ebx
    movl %ebx, -8(%ebp) #save ebx
    movl $fmt_fibo, (%esp)
    movl %ebx, 4(%esp)
    call printf

    movl -4(%ebp), %eax
    movl -8(%ebp), %ebx
    movl $12, %ecx
lc1:
    addl %ebx, %eax

    movl %ebx, -8(%ebp) #save 
    movl %ecx, -12(%ebp) #save

    movl $fmt_fibo, (%esp)
    movl %eax, 4(%esp)
    call printf

    movl 4(%esp), %eax  # load
    movl -8(%ebp), %ebx #load 
    movl -12(%ebp), %ecx #load

    xchgl %ebx, %eax
    loop lc1
    
    addl $32, %esp
    movl %ebp, %esp
    popl %ebp
    ret
