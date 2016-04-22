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

all:$(TARGET) c_call_asm_func

$(TARGET):$(OBJS)
	$(LD) -dynamic-linker /lib/ld-linux.so.2 -o $@ $(OBJS) $(LFLAGS) 

# c call the asm funcion 
CC_OBJS = m.o 11.2.string.o
CC_TARGET= c_call_asm

c_call_asm_func: $(CC_TARGET)

$(CC_TARGET):$(CC_OBJS)
	gcc -o $@ $(CC_OBJS)

clean_cc:
	rm -frv $(CC_TARGET) $(CC_OBJS)

%.o:%.s
	$(AS) $(ASFLAGS) -o $@ $<
%.o:%.c
	gcc -c $<

clean: clean_cc
	@rm -f $(TARGET) $(OBJS)
