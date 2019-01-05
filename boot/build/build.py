#!/usr/bin/python
import sys
import struct

MAX_BOOT_SECTOR_SIZE = 512 #(bootsector)

IMG_SIZE    = 80*18*512*2


def write_boot_sector(bootsector, setup, img_out):
    fimg = open(img_out, "wb")


    #read bootsector
    fbs = open(bootsector, "rb") 
    bs = fbs.read() 
    fbs_sz = fbs.tell() 
    fbs.close()

    if fbs_sz > MAX_BOOT_SECTOR_SIZE:
        print("error: the input bootsector size > = MAX_BOOT_SECTOR_SIZE(%d)" % MAX_BOOT_SECTOR_SIZE);
        return 
    #end if
    fimg.write(bs) 


    fbs = open(setup, "rb") 
    bs = fbs.read() 
    fbs_sz = fbs.tell() 
    fbs.close()
    fimg.write(bs) 


    #pad 0x00
    byte = struct.pack('c', '\0')
    pad_write_cnt = IMG_SIZE - MAX_BOOT_SECTOR_SIZE -  512*4
    for i in range(pad_write_cnt):
        fimg.write(byte)
    
    #close img_out
    fimg.close()

#end def


if __name__ == "__main__":
    if len(sys.argv) >= 4:
        bootsector = sys.argv[1]
        setup = sys.argv[2]
        img_out = sys.argv[3]
        write_boot_sector(bootsector, setup, img_out)
        print("building the floppy, args:", sys.argv) 
    #end if
