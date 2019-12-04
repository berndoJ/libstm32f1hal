# ------------------------------------------------------------------------------
# @file Makefile
# Project: libstm32f1hal
# ------------------------------------------------------------------------------
# @author Johannes Berndorfer (berndoJ) [johannes@berndorfer.com]
# @date 04 Dec 2019
# ------------------------------------------------------------------------------
# Copyright (c) 2019 by Johannes Berndorfer (berndoJ) [johannes@berndorfer.com]
# ------------------------------------------------------------------------------
# @brief  Main makefile for this project.
#         This file will output a compiled static library (.a) for use in other
#         STM32 microcontroller projects. This library supports the following
#         target chip configurations:
#          - STM32F100xB
#          - STM32F100xE
#          - STM32F101x6
#          - STM32F101xB
#          - STM32F101xE
#          - STM32F101xG
#          - STM32F102x6
#          - STM32F102xB
#          - STM32F103x6
#          - STM32F103xB
#          - STM32F103xE
#          - STM32F103xG
#          - STM32F105xC
#          - STM32F107xC
# ------------------------------------------------------------------------------

# --- MAKEFILE SETTINGS ---
PROJECTNAME   = libstm32f1hal
VERSION_MAJOR = 1
VERSION_MINOR = 8
VERSION_REV   = 0

# --- COMPILER COMMANDS ---
GCC_PREFIX = arm-none-eabi-
GCC_CC     = $(GCC_PREFIX)gcc
GCC_ASM    = $(GCC_PREFIX)gcc -x assembler-with-gcc
GCC_AR     = $(GCC_PREFIX)ar

# --- C DEFINES ---
C_DEFS  = -DUSE_HAL_DRIVER
C_DEFS += -DLIBSTM32F1HAL_VER_MAJ=$(VERSION_MAJOR)
C_DEFS += -DLIBSTM32F1HAL_VER_MIN=$(VERSION_MINOR)
C_DEFS += -DLIBSTM32F1HAL_VER_REV=$(VERSION_REV)

# --- COMPILER FLAGS ---
MCU_FLAGS = -mcpu=cortex-m3 -mthumb
OPTIM_FLAGS = -Os
GCC_CC_FLAGS = $(MCU_FLAGS) $(OPTIM_FLAGS) $(C_DEFS) -Wall -fdata-sections -ffunction-sections -MMD -MP -MF"$(@:%.o=%.d)" -Wa,-a,-ad,-ahlms=$(<:.c=.lst)
GCC_ASM_FLAGS = $(MCU_FLAGS) $(OPTIM_FLAGS) -Wall -fdata-sections -ffunction-sections

# --- SOURCE AND BIN DIRECTORIES ---
SRCDIR = ./src
BINDIR = ./bin

# --- SOURCE FILES ---
C_SRC  = Legacy/stm32f1xx_hal_can.c
C_SRC += stm32f1xx_hal.c
C_SRC += stm32f1xx_hal_adc.c
C_SRC += stm32f1xx_hal_adc_ex.c
C_SRC += stm32f1xx_hal_can.c
C_SRC += stm32f1xx_hal_cec.c
C_SRC += stm32f1xx_hal_cortex.c
C_SRC += stm32f1xx_hal_crc.c
C_SRC += stm32f1xx_hal_dac.c
C_SRC += stm32f1xx_hal_dac_ex.c
C_SRC += stm32f1xx_hal_dma.c
C_SRC += stm32f1xx_hal_eth.c
C_SRC += stm32f1xx_hal_exti.c
C_SRC += stm32f1xx_hal_flash.c
C_SRC += stm32f1xx_hal_flash_ex.c
C_SRC += stm32f1xx_hal_gpio.c
C_SRC += stm32f1xx_hal_gpio_ex.c
C_SRC += stm32f1xx_hal_hcd.c
C_SRC += stm32f1xx_hal_i2c.c
C_SRC += stm32f1xx_hal_i2s.c
C_SRC += stm32f1xx_hal_irda.c
C_SRC += stm32f1xx_hal_iwdg.c
C_SRC += stm32f1xx_hal_mmc.c
C_SRC += stm32f1xx_hal_nand.c
C_SRC += stm32f1xx_hal_nor.c
C_SRC += stm32f1xx_hal_pccard.c
C_SRC += stm32f1xx_hal_pcd.c
C_SRC += stm32f1xx_hal_pcd_ex.c
C_SRC += stm32f1xx_hal_pwr.c
C_SRC += stm32f1xx_hal_rcc.c
C_SRC += stm32f1xx_hal_rcc_ex.c
C_SRC += stm32f1xx_hal_rtc.c
C_SRC += stm32f1xx_hal_rtc_ex.c
C_SRC += stm32f1xx_hal_sd.c
C_SRC += stm32f1xx_hal_smartcard.c
C_SRC += stm32f1xx_hal_spi.c
C_SRC += stm32f1xx_hal_sram.c
C_SRC += stm32f1xx_hal_tim.c
C_SRC += stm32f1xx_hal_tim_ex.c
C_SRC += stm32f1xx_hal_uart.c
C_SRC += stm32f1xx_hal_usart.c
C_SRC += stm32f1xx_hal_wwdg.c
C_SRC += stm32f1xx_ll_adc.c
C_SRC += stm32f1xx_ll_crc.c
C_SRC += stm32f1xx_ll_dac.c
C_SRC += stm32f1xx_ll_dma.c
C_SRC += stm32f1xx_ll_exti.c
C_SRC += stm32f1xx_ll_fsmc.c
C_SRC += stm32f1xx_ll_gpio.c
C_SRC += stm32f1xx_ll_i2c.c
C_SRC += stm32f1xx_ll_pwr.c
C_SRC += stm32f1xx_ll_rcc.c
C_SRC += stm32f1xx_ll_rtc.c
C_SRC += stm32f1xx_ll_sdmmc.c
C_SRC += stm32f1xx_ll_spi.c
C_SRC += stm32f1xx_ll_tim.c
C_SRC += stm32f1xx_ll_usart.c
C_SRC += stm32f1xx_ll_usb.c
C_SRC += stm32f1xx_ll_utils.c

# --- INCLUDE DIRECTORIES ---
INC  = ./inc
INC += ./cmsis/inc

# ------------------------------------------------------------------------------

OBJ = $(C_SRC:.c=.o)

.PRECIOUS: $(SRCDIR)/%.c
.PRECIOUS: $(BINDIR)/%.o

.PHONY: clean \
		STM32F100xB \
		STM32F100xB_CFG

all: STM32F100xB

STM32F100xB: STM32F100xB_CFG $(BINDIR)/STM32F100xB/$(PROJECTNAME).a

STM32F100xB_CFG:
	@mkdir -p $(BINDIR)/STM32F100xB
	C_DEFS += -DSTM32F100xB


clean:
	@echo "[$(PROJECTNAME)] Cleaning up..."
	@rm -rf $(BINDIR)/*
	@echo "[$(PROJECTNAME)] Cleaned up successfully!"

$(BINDIR)/%.o: $(SRCDIR)/%.c | $(BINDIR) $(SRCDIR)
	@if ! test -d $(dir $@); then mkdir -p $(dir $@); echo "[$(PROJECTNAME)] Creating subdirectory $(dir $@) for output binaries."; fi
	@echo "[$(PROJECTNAME)] Compiling $< -> $@"
	@$(GCC_CC) -c $(GCC_CC_FLAGS) $(INC) $< -o $@

$(BINDIR):
	@echo "[$(PROJECTNAME)] Creating folder $(BINDIR)..."
	@mkdir -p $(BINDIR)

$(SRCDIR):
	@echo "[$(PROJECTNAME)] Creating folder $(SRCDIR)..."
	@mkdir -p $(SRCDIR)