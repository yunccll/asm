BOOTSECT    = 0x07c0
    .code16
    .global bootsect_start
bootsect_start:
    ljmp $BOOTSECT,$start2
start2:
    # clear the cs ds es ss, sp
    movw %cs, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %ss
    xorw %sp, %sp
    sti
    cld

    movw  $boot_msg, %si

msg_loop:
    lodsb
    andb %al, %al
    jz reboot
    movb $0xe, %ah
    movw $7,%bx
    int $0x10
    jmp msg_loop

reboot:
    xorw %ax, %ax
    int $0x16
    int $0x19

    ljmp $0xf000,$0xfff0

boot_msg:
    .ascii "hello world from my os\r\n"
    .byte 0

