
SUBTARGET := ./FileIO

C_SRCS := $(wildcard $(SUBTARGET)/*.c)
SUBOBJS := $(patsubst %.c, %.o, $(C_SRCS))
OBJS += $(patsubst $(SUBTARGET)/%.o, $(BUILD_PATH)/%.o, $(SUBOBJS))

$(BUILD_PATH)/%.o: $(SUBTARGET)/%.c | ./Makefile
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc $(D_FLAGS) $(I_FLAGS) $(C_FLAGS) $(LIBS) -o"$@" "$<"
	@echo 'Finished building: $@'
	@echo ' '


