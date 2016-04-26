
TARGET := a.img
BOOT_SECTOR :=../bootsector

all: $(TARGET)
	
$(TARGET): $(BOOT_SECTOR)
	python build.py $< $@


clean:
	rm -frv $(TARGET) *.o 
