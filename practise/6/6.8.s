.section .data
fmt_eax:
    .asciz "eax is 0x%x\n"
fmt_ebx:
    .asciz "sub-ebx is %u\n"
fmt_ecx:
    .asciz "add-ecx is 0x%x\n"
    
var1:
    .byte 0x01
fmt_above:
    .asciz "above\n"
fmt_blew:
    .asciz "blew\n"

fmt_failed:
    .asciz "failed\n"

.section .text
.global  _start
_start :
    pushl %ebp
    movl %esp, %ebp

    subl $16, %esp # 4*dword

    #  6.8.a ebx = 100 + 26 ; print it
    movl $100, %ebx
    addl $26, %ebx

    movl $fmt_ebx, (%esp)
    movl %ebx, 4(%esp)
    call printf

    #  6.8.b  ecx = 0x8000 - 0x4000 ; print it 
    movl $0x8000, %ecx
    subl $0x4000, %ecx

    movl $fmt_ecx, (%esp)
    movl %ecx, 4(%esp)
    call printf

    # 6.8.c   logical shift %ch to right for 2-bit
    movl 4(%esp), %ecx
    shrb $2, %ch #  shr --> [sh]ift  right;  sar [s]hift arithmetic right

    movl $fmt_ecx, (%esp)
    movl %ecx, 4(%esp)
    call printf

    
    # 6.8.d
    movb var1,%al
    shlb $2, %al
    movl $fmt_eax, (%esp)
    movl %eax, 4(%esp)
    call printf

    # 6.8.e
    movl $426, %ecx

    movl $fmt_ecx, (%esp)
    movl %ecx, 4(%esp)
    call printf

# check printf return value
    cmp $0, %eax 
    jnz next
    movl $fmt_failed, (%esp)
    call printf
next:

    # 6.8.e
    xor %eax, %eax
    movb var1, %al
    cmp $25, %eax
    ja above
    movl $fmt_blew, (%esp)
    call printf
    jmp then
above:
    movl $fmt_above, (%esp)
    call printf
then:

    addl $8, %esp
    
    movl %ebp, %esp
    popl %ebp

    movl $1, %eax
    movl $0, %ebx
    int $0x80 # exit-1(0)
