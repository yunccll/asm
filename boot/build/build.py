#!/usr/bin/python
import sys
import struct

MAX_BOOT_SECTOR_SIZE = 512

IMG_SIZE    = 80*18*512*2


def write_boot_sector(bootsector, img_out):
    fbs = open(bootsector, "rb") 
    bs = fbs.read() 
    fbs_sz = fbs.tell() 
    fbs.close()

    if fbs_sz > MAX_BOOT_SECTOR_SIZE:
        print("error: the input bootsector size > = MAX_BOOT_SECTOR_SIZE(%d)" % MAX_BOOT_SECTOR_SIZE);
        return 
    #end if


    fimg = open(img_out, "wb")
    fimg.write(bs) 

    byte = struct.pack('c', '\0')
    boot_bound_cnt = MAX_BOOT_SECTOR_SIZE - 2 - fbs_sz
    for i in range(boot_bound_cnt):
        fimg.write(byte)

    fimg.write(struct.pack('B', 0x55))
    fimg.write(struct.pack('B', 0xaa))


    pad_write_cnt = IMG_SIZE - MAX_BOOT_SECTOR_SIZE
    for i in range(pad_write_cnt):
        fimg.write(byte)
    fimg.close()

#end def


if __name__ == "__main__":
    if len(sys.argv) >= 3:
        bootsector = sys.argv[1]
        img_out = sys.argv[2]
        write_boot_sector(bootsector, img_out)
        print("building the floppy, args:", sys.argv) 
    #end if
