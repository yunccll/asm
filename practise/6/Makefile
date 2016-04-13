APP_PATH= .
INC_PATH= $(APP_PATH)
LIB_PATH= $(APP_PATH)


SRC_NAME = $(patsubst %.s, %, $(wildcard *.s))
OBJS=$(addsuffix .o, $(SRC_NAME))

TARGET= main


STATIC_LIBS=c
DYNAMIC_LIBS=m

ASFLAGS= -gstabs #$(addprefix -I, $(INC_PATH)) -Wwrite-strings -DUNIT_TESTING #-Werror 
#LFLAGS= $(addprefix -L, $(LIB_PATH)) -Wl,-Bstatic $(addprefix -l, $(STATIC_LIBS)) -Wl,-Bdynamic $(addprefix -l, $(DYNAMIC_LIBS)) 
LFLAGS= $(addprefix -L, $(LIB_PATH)) $(addprefix -l, $(STATIC_LIBS))

AS=as
LD=ld

all:$(TARGET)

$(TARGET):$(OBJS)
	$(LD) -dynamic-linker /lib/ld-linux.so.2 -o $@ $(OBJS) $(LFLAGS) 


%.o:%.s
	$(AS) $(ASFLAGS) -o $@ $<

clean:
	@rm -f $(TARGET) $(OBJS)
