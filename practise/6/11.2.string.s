    .section    .data


    .section    .rodata
    src_text:
    .asciz "strings from base\n"

    s_text:
    .ascii "123"
    d_text:
    .ascii "1234"

    str_above:
    .asciz "above\n"
    str_blew:
    .asciz "blew\n"
    str_equ:
    .asciz "equal\n"

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

    movl $result, (%esp)
    call printf

    #cmp string
    .equ text_len,  4
    movl $s_text, %esi
    movl $d_text, %edi
    movl $text_len, %ecx
    cld
    repe cmpsb
    ja above
    jb  blew
    #cmp $0, %ecx
    #jz equal
    movl $str_equ, (%esp)
    call printf
    jmp next
blew:
    movl $str_blew, (%esp)
    call printf
    jmp next

above:
    movl $str_above, (%esp)
    call printf
next:
    addl $32, %esp
    movl %ebp, %esp
    popl %ebp
    ret
