#   seg_setup --> 0x9000
    .code16
setup_start:
    movw %cs, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %ss
	movw $0xff00, %sp

    movw $msg_run_setup, %si  # trace_log 
    call print_cstr

    cli 

    #enable A20 
    call wait_to_8042_empty

    movb $0xD1, %al  # send command to ctrl port: will input data to 8042
    out %al, $0x64
    call wait_to_8042_empty

    movb $0xDF, %al # send data to 8042  input register
    out %al, $0x60
    call wait_to_8042_empty  # wait the 8042 input buffer empty

    # check a20
    call check_a20

    testb %al,%al
    je a20_ok       # al == 0

    movw $msg_a20_disable, %si   # show a20 disable  # trace_log
    call print_cstr
    jmp  next

a20_ok:
    movw $msg_a20_enable, %si   # show a20 enable   #trace_log
    call print_cstr             
next:

    lgdt gdt_48
    #lidt idt_48 # TODO: will uncomment it

#TODO:  will start
    #enable  protected mode
    #movw $0x1, %ax
    #lmsw %ax
    #ljmp $0x8,$0x0



    xorw %ax, %ax
    int $0x16   # get a key
    int $0x19   # reboot 
    ljmp $0xf000,$0xfff0


gdt:
    .word 0, 0, 0, 0

    .word 0x07ff
    .word 0x0000
    .word 0x9a00
    .word 0x00c0

    .word 0x07ff 
    .word 0x0000
    .word 0x9200
    .word 0x00c0

idt_48:
    .word 0
    .word 0, 0 
gdt_48:
    .word 0x800
    .word gdt,0x9

check_a20:
    #TODO:  0x0000:0x500 == 0xFFFF:0x510
    movb $0, %al
    ret

wait_to_8042_empty:
    .word 0x00eb, 0x00eb
    in $0x64, %al
    testb $0x2, %al
    jne wait_to_8042_empty
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

msg_run_setup:
    .asciz "setup start runing....\r\n"
msg_a20_enable:
    .asciz "a20 enabled \r\n"
msg_a20_disable:
    .asciz "a20 disable \r\n"


.org 512*4 -2
    .word 0xAA55
