
TARGET := a.img
BOOT_SECTOR :=../bootsector.bin  ../setup.bin

all: $(TARGET)
	
$(TARGET): $(BOOT_SECTOR)
	python build.py $^ $@


clean:
	rm -frv $(TARGET) *.o 
