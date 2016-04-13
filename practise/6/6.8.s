.section .data
output:
    .ascii "The processor Vendor ID is 'xxxxxxxxxxxx'\n"
.section .text
.global  _start
_start :

    movl $0, %eax
    cpuid 
    movl $output, %edi   #$output --> the memory location itself
    movl %ebx, 28(%edi)  # Genu
    movl %edx, 32(%edi) #ineI
    movl %ecx, 36(%edi) #ntel

    #movw output, %bx  # output --> the memory location 's value
    #movw %bx, 1(%edi)

    pushl $output
    call printf
    addl $4, %esp

    movl $1, %eax
    movl $0, %ebx
    int $0x80 # exit-1(0)
