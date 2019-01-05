
ENTRY	:=bootsect_start
OBJS 	:= bootsector.o setup.o

TARGET := bootsector.bin setup.bin


all:  $(TARGET) build


#$(TARGET):
	#as --32 -o bootsector.o bootsector.s
	#ld -s -m elf_i386 -e $(ENTRY) -Ttext=0x0 --oformat=binary  -o $@ $^
	#ld -s -m elf_i386 -e $(ENTRY) -o $@ $< a.o


dump:
	objdump -D -b binary -m i8086 bootsector.bin
	objdump -D -b binary -m i8086 setup.bin

dis:$(OBJS)
	objdump -d $<


%.bin:%.o
	ld -s -m elf_i386 -Ttext=0x0 --oformat=binary  -o $@ $<

%.o:%.c
	gcc -m16  -c $<
%.o:%.s
	as --32 -o $@ $<


build: $(TARGET)
	make -C ./build

clean_build:
	make -C ./build  clean



clean: clean_build
	rm -frv *.o $(TARGET)
	
