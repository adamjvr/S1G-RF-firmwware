######################################
# Makefile by CubeMX2Makefile.py
######################################

######################################
# target
######################################
TARGET = S1G_RF_STM32_Drivers

######################################
# building variables
######################################
# debug build?
DEBUG = 1
# optimization
OPT = -O0

#######################################
# pathes
#######################################
# Build path
BUILD_DIR = build

######################################
# source
######################################
C_SOURCES = \
  Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Src/usbd_cdc.c \
  Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ioreq.c \
  Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_core.c \
  Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ctlreq.c \
  Src/stm32l0xx_it.c \
  Src/usbd_desc.c \
  Src/stm32l0xx_hal_msp.c \
  Src/usbd_cdc_if.c \
  Src/usart.c \
  Src/usbd_conf.c \
  Src/spi.c \
  Src/gpio.c \
  Src/main.c \
  Src/usb_device.c \
	Src/ADF7023.c \
	Src/Communication.c \
  Drivers/CMSIS/Device/ST/STM32L0xx/Source/Templates/system_stm32l0xx.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_tim.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_gpio.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_uart.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_spi.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_cortex.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_flash_ramfunc.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_rcc_ex.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_dma.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_i2c_ex.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_flash.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_pcd.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_uart_ex.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_pwr_ex.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_rcc.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_i2c.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_tim_ex.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_flash_ex.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_pcd_ex.c \
  Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_pwr.c
ASM_SOURCES = \
  Drivers/CMSIS/Device/ST/STM32L0xx/Source/Templates/gcc/startup_stm32l052xx.s

#######################################
# binaries
#######################################
CC = /usr/local/gcc-arm-none-eabi-5_4-2016q2/bin/arm-none-eabi-gcc
AS = /usr/local/gcc-arm-none-eabi-5_4-2016q2/bin/arm-none-eabi-gcc -x assembler-with-cpp
CP = /usr/local/gcc-arm-none-eabi-5_4-2016q2/bin/arm-none-eabi-objcopy
AR = /usr/local/gcc-arm-none-eabi-5_4-2016q2/bin/arm-none-eabi-ar
SZ = /usr/local/gcc-arm-none-eabi-5_4-2016q2/bin/arm-none-eabi-size
HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S

#######################################
# CFLAGS
#######################################
# macros for gcc
AS_DEFS =
C_DEFS = -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32L052xx
# includes for gcc
AS_INCLUDES =
C_INCLUDES = -IMiddlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc
C_INCLUDES += -IMiddlewares/ST/STM32_USB_Device_Library/Core/Inc
C_INCLUDES += -IInc
C_INCLUDES += -IDrivers/CMSIS/Include
C_INCLUDES += -IDrivers/CMSIS/Device/ST/STM32L0xx/Include
C_INCLUDES += -IDrivers/STM32L0xx_HAL_Driver/Inc
C_INCLUDES += -IDrivers/STM32L0xx_HAL_Driver/Inc/Legacy
# compile gcc flags
ASFLAGS = -mthumb -mcpu=cortex-m0 $(AS_DEFS) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections
CFLAGS = -mthumb -mcpu=cortex-m0 $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections
ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif
# Generate dependency information
CFLAGS += -std=c99 -MD -MP -MF .dep/$(@F).d

#######################################
# LDFLAGS
#######################################
# link script
LDSCRIPT = STM32L052C8Tx_FLASH.ld
# libraries
LIBS = -lc -lm -lnosys
LIBDIR =
LDFLAGS = -mthumb -mcpu=cortex-m0 -specs=nano.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections

# default action: build all
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin

#######################################
# build the application
#######################################
# list of objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR)
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(HEX) $< $@

$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(BIN) $< $@

$(BUILD_DIR):
	mkdir -p $@

#######################################
# clean up
#######################################
clean:
	-rm -fR .dep $(BUILD_DIR)

#######################################
# dependencies
#######################################
-include $(shell mkdir .dep 2>/dev/null) $(wildcard .dep/*)

.PHONY: clean all

# *** EOF ***
