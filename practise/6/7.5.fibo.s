    .section    .data
char_string:
    .asciz "ABcdeFGHIJZ\n"
char_string2:
    .asciz "ABCDEFGHIJZ\n"

    .section .rodata
fmt_fibo:
    .asciz "fibonacci is %u\n" 


    .text
    .global p_7_5
    .type p_7_5 @function
p_7_5:
    pushl %ebp
    movl %esp, %ebp
    subl $32, %esp
    
    # 7.5 fibonacci sequence
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
    
    
    #7.7 string to lower with lods stos
    movl $char_string, %esi
    movl %esi, %edi
    movl $12, %ecx
    cld
cvt:
    lodsb 

    # if al >= A && al <=Z
    cmp $0x41,%al
    jb mov_char_string
    cmp $0x5A,%al
    ja mov_char_string
    addb $0x20, %al

mov_char_string:
    stosb
    loop cvt

    movl $char_string, (%esp)
    call printf


    #7.7 indirect-address for to_lower
    xor %ebx, %ebx
cvt_indirect:
    movb char_string2(,%ebx,1), %al

    cmp $0x41,%al
    jb mov_char_string2
    cmp $0x5A,%al
    ja mov_char_string2
    addb $0x20, %al

mov_char_string2:
    movb %al, char_string2(, %ebx, 1)
    inc %ebx
    cmp $12,%ebx
    jb cvt_indirect

    movl $char_string2, (%esp)
    call printf

    addl $32, %esp
    movl %ebp, %esp
    popl %ebp
    ret
