


TARGET := bootsector


all:  $(TARGET) build


$(TARGET):  bootsector.s
	as -o bootsector.o bootsector.s
	ld -s -e bootsect_start -Ttext=0x0 --oformat=binary  -o bootsector bootsector.o


build: $(TARGET)
	make -C ./build

clean_build:
	make -C ./build  clean

clean: clean_build
	rm -frv *.o $(TARGET)
	
