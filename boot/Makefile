
ENTRY	:=bootsect_start
OBJS 	:= bootsector.o

TARGET := bootsector


all:  $(TARGET) build


$(TARGET):$(OBJS)
	#as --32 -o bootsector.o bootsector.s
	ld -s -m elf_i386 -e $(ENTRY) -Ttext=0x0 --oformat=binary  -o $@ $<

dis:$(OBJS)
	objdump -d $<
	

%.o:%.s
	as --32 -o $@ $<


build: $(TARGET)
	make -C ./build

clean_build:
	make -C ./build  clean



clean: clean_build
	rm -frv *.o $(TARGET)
	
