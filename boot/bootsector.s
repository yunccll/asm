seg_bootsector  = 0x07c0 
bootsector_len  = 1

seg_setup       = 0x9000    # setup 0x9000:0000
setup_len       = 4         # 4 sectors

seg_system      = 0x1000    # system 0x1000:0000  len = ???
system_len      = 0x3000    # 0x3000 Byte

    .code16
    .global bootsect_start
bootsect_start:
    ljmp $seg_bootsector,$start

start:
    # clear the cs ds es ss
    movw %cs, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %ss
	movw $0xff00, %sp

    movw  $msg_load_setup, %si
    call print_cstr

    movw $seg_setup, %ax
    movw %ax, %es
    xorw %bx, %bx
    call load_setup_in_floppy

    #TODO: 

    movw  $msg_load_system, %si
    call print_cstr

    #TODO: load system in floppy
    #movw $seg_system, %ax
    #movw %ax, %es
    #xorw %bx, %bx
    #call load_system_in_floppy

    ljmp $seg_setup,$0x00


# es:bx must be set
load_setup_in_floppy:
    movb $0x02, %ah     # function idx
    movb $setup_len, %al    # sector numbers
    movb $0x00, %dl     # driver 0
    movb $0x00, %dh     # head 0
    movb $0x00, %ch      # track 0
    movb $0x02, %cl      # sector start 2
    int $0x13
    jb error
    ret
error:
    movw $0x0000, %ax
    movw $0x0000, %dx
    int $0x13
    jmp load_setup_in_floppy
    ret

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


msg_load_setup:
    .asciz "loading setup\r\n"
msg_load_system:
    .asciz "loading system\r\n"

.org 510
    .byte 0x55
    .byte 0xaa
