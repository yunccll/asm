APP_PATH= .

INC_PATH= $(HOME)/tools/lua-5.1.4/src
LIB_PATH= $(HOME)/tools/lua-5.1.4/src

DYNAMIC_LIBS= rt dl
STATIC_LIBS=

SRC_NAME = $(patsubst %.cpp, %, $(wildcard *.cpp))   $(patsubst %.c, %, $(wildcard *.c)) 

TARGET= main

CC=gcc

DEBUG_FLAGS= -g -Wwrite-strings -Werror

CFLAGS= $(addprefix -I, $(INC_PATH)) $(DEBUG_FLAGS)
LFLAGS= $(DEBUG_FLAGS) $(addprefix -L, $(LIB_PATH)) -Wl,-Bstatic $(addprefix -l, $(STATIC_LIBS)) -Wl,-Bdynamic $(addprefix -l, $(DYNAMIC_LIBS))
OBJS=$(addsuffix .o, $(SRC_NAME))

ASM_SRC=$(addsuffix .s, $(SRC_NAME))

all:$(TARGET) asm

asm:$(ASM_SRC)

$(TARGET):$(OBJS)
	$(CC) -o $@ $(OBJS) $(LFLAGS) 

%.o:%.c
	$(CC) $(CFLAGS) -c $<

%.o:%.cpp
	$(CC) $(CFLAGS) -c $<
	
%.s:%.c
	$(CC) -S -c $<

clean:
	@rm -f $(TARGET) $(OBJS) *.o $(ASM_SRC)
