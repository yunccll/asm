    .section    .data


    .section    .rodata
src_text:
    .asciz "strings from base\n"

    .section    .bss
    .lcomm  result  64
    

    .text
    .global p_11_2
    .type p_11_2 @function
p_11_2:
    pushl %ebp
    movl %esp, %ebp
    subl $32, %esp

    .equ src_text_len,18

    # 11.2 mov string with rep movsb 
    movl $src_text, %esi
    movl $result, %edi
    movl $src_text_len, %ecx
    cld
    rep movsb 



    movl $result, (%esp)
    call printf

    # --- clear the result
    movl $result-1, %edi
    addl $src_text_len, %edi

    movl $src_text_len, %ecx
    movb $0, %al
    std 
    rep stosb

    movl $result, (%esp)
    call printf


    # 11.2 mov string with lods stos
    movl $src_text, %esi
    movl $result, %edi
    movl $src_text_len, %ecx
    cld
    
repeat:
    lodsb
    stosb
    loop repeat

    #


    movl $result, (%esp)
    call printf
    

    addl $32, %esp
    movl %ebp, %esp
    popl %ebp
    ret
