# include $(PROJECT_DIR)/hw_layer/ports/stm32/stm32_common.mk

# HW_LAYER_EMS += $(PROJECT_DIR)/hw_layer/ports/stm32/stm32f4/stm32f4xx_hal_flash.c \
# 				$(PROJECT_DIR)/hw_layer/ports/stm32/stm32f4/stm32f4xx_hal_flash_ex.c \
               
# HW_LAYER_EMS_CPP += $(PROJECT_DIR)/hw_layer/ports/stm32/stm32f4/mpu_util.cpp \
# 					$(PROJECT_DIR)/hw_layer/ports/stm32/stm32_adc_v2.cpp \

DDEFS += -DSTM32F103xx
MCU = cortex-m4
# LDSCRIPT = $(PROJECT_DIR)/hw_layer/ports/stm32/stm32f1/STM32F103xG.ld
ALLCSRC += $(CHIBIOS)/os/hal/boards/STM32F103C8_MINIMAL/board.c
CONFDIR = $(PROJECT_DIR)/hw_layer/ports/stm32/stm32f1/cfg

ALLINC += $(PROJECT_DIR)/config/stm32f1ems

include ${CHIBIOS_CONTRIB}/os/hal/ports/STM32/LLD/CRCv1/driver.mk
include ${CHIBIOS_CONTRIB}/os/hal/ports/STM32/LLD/TIMv1/driver.mk
include ${CHIBIOS_CONTRIB}/os/hal/ports/STM32/LLD/COMPv1/driver.mk

ifeq ($(USE_SMART_BUILD),yes)
ifneq ($(findstring HAL_USE_CRC TRUE,$(HALCONF)),)
PLATFORMSRC_CONTRIB += ${CHIBIOS_CONTRIB}/os/hal/ports/STM32/LLD/CRCv1/hal_crc_lld.c
endif
else
PLATFORMSRC_CONTRIB += ${CHIBIOS_CONTRIB}/os/hal/ports/STM32/LLD/CRCv1/hal_crc_lld.c
endif

PLATFORMINC_CONTRIB += ${CHIBIOS_CONTRIB}/os/hal/ports/STM32/LLD/CRCv1