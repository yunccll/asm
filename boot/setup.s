#   seg_setup --> 0x9000
    .code16
setup_start:
    movw %cs, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %ss
	movw $0xff00, %sp

    movw $msg_run_setup, %si
    call print_cstr

    xorw %ax, %ax
    int $0x16   # get a key
    int $0x19   # reboot 
    ljmp $0xf000,$0xfff0

print_cstr:  #(print_cstr(es:si=>string)
    pushw %ax
    pushw %bx
    cld
next_char:
    lodsb
    andb %al, %al
    jz end

    movb $0x0e, %ah
    movw $0x01,%bx
    int $0x10
    jmp next_char
end:
    popw %bx
    popw %ax
    ret

msg_run_setup:
    .asciz "setup start runing....\r\n"

.org 512*4 -2
    .word 0xAA55
