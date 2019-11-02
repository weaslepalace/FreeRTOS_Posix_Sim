

print-%:
	@echo $* = $($*)

HEADERS := $(shell find ./ -type f -iname '*.h')
HEADER_PATHS := $(shell find ./ -name 'include')

D_FLAGS := \
	-D__GCC_POSIX__=1\
	-DDEBUG_BUILD=1\
	-DUSE_STDIO=1\

LIBS := \
	-pthread \
	-lrt \
	
C_FLAGS := -g -Wall -c -fmessage-length=0 -fPIC -Wno-pointer-sign -O0

I_FLAGS := $(addprefix -I, $(HEADER_PATHS))

OBJS :=

BUILD_PATH := ./build
$(info $(shell mkdir -p $(BUILD_PATH)))

SUBDIRS := $(shell find ./ -type f -name component.mk)
include $(SUBDIRS)

FreeRTOS: $(OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking Linker'
	gcc -shared $(OBJS) -o $(BUILD_PATH)/lib$@.so
	@echo 'Done'
	@echo ' '

.PHONY: all install clean

all: FreeRTOS

install:
	@cp $(BUILD_PATH)/libFreeRTOS.so /usr/lib/
	@mkdir -p /usr/include/freeRTOS
	@cp $(HEADERS) /usr/include/freeRTOS
	
clean:
	-@rm $(OBJS)
	-@rm $(BUILD_PATH)/libFreeRTOS.so 
