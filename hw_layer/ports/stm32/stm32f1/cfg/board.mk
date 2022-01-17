
DDEFS += -DSTM32F103xx
MCU = cortex-m3
LDSCRIPT = $(PROJECT_DIR)/hw_layer/ports/stm32/stm32f1/STM32F103xB.ld

include $(CHIBIOS)/os/common/startup/ARMCMx/compilers/GCC/mk/startup_stm32f1xx.mk
include $(CHIBIOS)/os/hal/ports/STM32/STM32F1xx/platform.mk
include $(CHIBIOS)/os/common/ports/ARMv7-M/compilers/GCC/mk/port.mk


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


