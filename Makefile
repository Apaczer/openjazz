# OpenJazz makefile

CROSS_COMPILE=/opt/mipsel-linux-uclibc/usr/bin/mipsel-linux-
CC=$(CROSS_COMPILE)gcc
CXX=$(CROSS_COMPILE)g++
SYSROOT=$(shell $(CC) --print-sysroot)
INCLUDE=$(SYSROOT)/usr/include

include openjazz.mk

OpenJazz: $(OBJS)
	$(CXX) -Wall -I$(INCLUDE) -I$(INCLUDE)/libmodplug -I$(INCLUDE)/SDL $(OBJS) -o OpenJazz -Wl,-Bstatic -lSDL ./lib/libSDL.a -L./lib -Wl,-Bdynamic -lmodplug -lz -lpthread -lstdc++ 


%.o: %.cpp
	$(CXX) -Wall -DRS97 -DUSE_MODPLUG -I$(INCLUDE) -I$(INCLUDE)/libmodplug -I$(INCLUDE)/SDL -Isrc -O3 -c $< -o $@
# 
#-DGFX8TO16BIT
#-DUSE_MODPLUG
#-DUSE_SOCKETS

clean:
	rm -f OpenJazz $(OBJS)
