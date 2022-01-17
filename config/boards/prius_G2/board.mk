# Combine the related files for a specific platform and MCU.

# Target ECU board design
BOARDCPPSRC = $(BOARDS_DIR)/prius_G2/board_configuration.cpp

# Target processor details
ifeq ($(PROJECT_CPU),ARCH_STM32F4)
  BOARDINC  = $(BOARDS_DIR)/prius_G2
  BOARDINC += $(PROJECT_DIR)/config/stm32f4ems	# For board.h
endif

ifeq ($(PROJECT_CPU),ARCH_STM32F1)
  # CONFDIR = $(PROJECT_DIR)/hw_layer/ports/stm32/stm32f1/cfg
  BOARDINC  = $(BOARDS_DIR)/prius_G2
  BOARDINC += $(PROJECT_DIR)/config/stm32f1ems	# For board.h
endif


EFI_CONSOLE_TTL_PINS = -DEFI_CONSOLE_TX_BRAIN_PIN=GPIOB_10 -DEFI_CONSOLE_RX_BRAIN_PIN=GPIOB_11


# Add them all together
DDEFS += -DEFI_USE_OSC=TRUE -DFIRMWARE_ID=\"prius_G2\" $(DEFAULT_ENGINE_TYPE) $(LED_CRITICAL_ERROR_BRAIN_PIN) $(EFI_CONSOLE_TTL_PINS) -DEFI_SOFTWARE_KNOCK=TRUE -DSTM32_ADC_USE_ADC3=TRUE 

# We are running on prius_G2 hardware!
DDEFS += -DHW_PRIUS_G2=1

# Shared variables
ALLCPPSRC += $(BOARDCPPSRC)
ALLINC    += $(BOARDINC)