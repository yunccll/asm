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
    subw %sp, %sp
    
    # get the video mode 
    movb $0x0f, %ah
    int $0x10
    movb %ah, nr_cols
    movb %al, video_mode
    movb %bh, cur_disp_page

    # read the cursor position & size
    movb $0x03, %ah
    movb $0x00, %bh
    int $0x10
    # ch = 0x06   0b0000 0110 start scan line
    # cl = 0x07   0b0000 0111 ending scan line
    # dh = 0x12   row  (0-based)
    # dl = 0x00   column

    # set the cursor type
    movb $0x01, %ah
    movw $0x0607, %cx
    int $0x10

    #set the cursor position to 0,0
    movb $0x02, %ah
    movb $0x00, %bh
    movw 0x0308, %dx  # dh -> row , dl -> columns
    int $0x10



    #sti
    cld
    movw  $boot_msg, %si

msg_loop:
    lodsb
    andb %al, %al
    jz reboot
    movb $0xe, %ah
    movw $1,%bx
    int $0x10
    # colorful display , but no cursor advance
    #movb $0x09, %ah
    #movw $0x0001, %bx
    #int $0x10
    #mov $1, %cx
    jmp msg_loop


reboot:
    # get the video mode  again
    movb $0x0f, %ah
    int $0x10
    
    #write the display memory directly
    movw $video_mem_seg_start, %ax
    movw %ax, %es

    movw $0,  %di
    movw $boot_msg_1, %bx
show:
    movb (%bx), %al    # mov the text into al
    andb %al,%al
    jz next
    stosb

    movb $0x4, %al # set the text attribute to red color, 0x07-white
    stosb

    inc %bx
    jmp show

next:
    xorw %ax, %ax
    int $0x16
    int $0x19

    ljmp $0xf000,$0xfff0

    video_mem_seg_start = 0xb800
    video_text_row      = 25
    video_text_columns  = 80

boot_msg:
    .ascii "hello world from my os\r\n"
    .byte 0
boot_msg_1:
    .ascii "1234234234234234wefasdfasdf"
    .byte 0

nr_cols:
    .byte 0 # AH 0x50
video_mode:
    .byte 0 #al  0x03
cur_disp_page:
    .byte 0 #BH   00
    
