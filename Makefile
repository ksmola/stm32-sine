##############################################################################
# Build global options
# NOTE: Can be overridden externally.
#

# Compiler options here.
ifeq ($(USE_OPT),)
  USE_OPT = -O0 -ggdb -fomit-frame-pointer -falign-functions=16
endif

# C specific options here (added to USE_OPT).
ifeq ($(USE_COPT),)
  USE_COPT = 
endif

# C++ specific options here (added to USE_OPT).
ifeq ($(USE_CPPOPT),)
  USE_CPPOPT = -std=gnu++11 -fno-exceptions -fno-rtti
endif

# Enable this if you want the linker to remove unused code and data.
ifeq ($(USE_LINK_GC),)
  USE_LINK_GC = yes
endif

# Linker extra options here.
ifeq ($(USE_LDOPT),)
  USE_LDOPT = 
endif

# Enable this if you want link time optimizations (LTO).
ifeq ($(USE_LTO),)
  USE_LTO = yes
endif

# Enable this if you want to see the full log while compiling.
ifeq ($(USE_VERBOSE_COMPILE),)
  USE_VERBOSE_COMPILE = no
endif

# If enabled, this option makes the build process faster by not compiling
# modules not used in the current configuration.
ifeq ($(USE_SMART_BUILD),)
  USE_SMART_BUILD = yes
endif

#
# Build global options
##############################################################################

##############################################################################
# Architecture or project specific options
#

# Stack size to be allocated to the Cortex-M process stack. This stack is
# the stack used by the main() thread.
ifeq ($(USE_PROCESS_STACKSIZE),)
  USE_PROCESS_STACKSIZE = 0x400
endif

# Stack size to the allocated to the Cortex-M main/exceptions stack. This
# stack is used for processing interrupts and exceptions.
ifeq ($(USE_EXCEPTIONS_STACKSIZE),)
  USE_EXCEPTIONS_STACKSIZE = 0x400
endif

# Enables the use of FPU (no, softfp, hard).
ifeq ($(USE_FPU),)
  USE_FPU = no
endif

# FPU-related options.
ifeq ($(USE_FPU_OPT),)
  USE_FPU_OPT = -mfloat-abi=$(USE_FPU) -mfpu=fpv4-sp-d16
endif

#
# Architecture or project specific options
##############################################################################

##############################################################################
# Project, target, sources and paths
#

# Define project name here
PROJECT = stm32-sine

PROJECT_DIR = .
BOARDS_DIR = $(PROJECT_DIR)/config/boards

# Imported source files and paths.
CHIBIOS  := ChibiOS
CONFDIR = $(PROJECT_DIR)/hw_layer/$(CPU_HWLAYER)/cfg
BUILDDIR := build
DEPDIR   := .dep

# # libopencm3 sources
LIBOPENINVCPPDIR := libopeninv/src

include stm32-sine.mk
# Licensing files.
include $(CHIBIOS)/os/license/license.mk
# Startup files.
include $(CHIBIOS)/os/common/startup/ARMCMx/compilers/GCC/mk/$(CPU_STARTUP)
# HAL-OSAL files (optional).
include $(CHIBIOS)/os/hal/hal.mk
include $(CHIBIOS)/os/hal/ports/STM32/STM32F1xx/platform.mk
include $(CHIBIOS)/os/hal/osal/rt-nil/osal.mk
# RTOS files (optional).
include $(CHIBIOS)/os/rt/rt.mk
include $(CHIBIOS)/os/common/ports/ARMv7-M/compilers/GCC/mk/port.mk
# Auto-build files in ./source recursively.
include $(CHIBIOS)/tools/mk/autobuild.mk
# Other files (optional).
include $(CHIBIOS)/os/test/test.mk
include $(CHIBIOS)/test/rt/rt_test.mk
include $(CHIBIOS)/test/oslib/oslib_test.mk
include $(CHIBIOS)/os/various/cpp_wrappers/chcpp.mk

include $(PROJECT_DIR)/config/boards/$(PROJECT_BOARD)/board.mk


# Define linker script file here
LDSCRIPT = $(STARTUPLD)/STM32F103xB.ld

# C sources that can be compiled in ARM or THUMB mode depending on the global
# setting.
CSRC = $(ALLCSRC) \
       hw_layer/$(CPU_HWLAYER)/cfg/board.c \
       $(TESTSRC) 

LIBOPENINVCPP = $(LIBOPENINVCPPDIR)/params.cpp \
                $(LIBOPENINVCPPDIR)/param_save.cpp \
                $(LIBOPENINVCPPDIR)/crc8.cpp \
                $(LIBOPENINVCPPDIR)/errormessage.cpp \
                $(LIBOPENINVCPPDIR)/fu.cpp

HALCONF := $(strip $(shell cat $(CONFDIR)/halconf.h $(CONFDIR)/halconf_community.h | egrep -e "\#define"))

# Add sources from ChibiOS-Contrib submodule
CHIBIOS_CONTRIB = ChibiOS-Contrib

ifneq ($(findstring HAL_USE_CRC TRUE,$(HALCONF)),)
HALSRC_CONTRIB += ${CHIBIOS_CONTRIB}/os/hal/src/hal_crc.c \
                  ${CHIBIOS_CONTRIB}/os/hal/src/hal_community.c \
                  ${CHIBIOS_CONTRIB}/os/hal/ports/STM32/LLD/CRCv1/hal_crc_lld.c

endif

PLATFORMINC_CONTRIB += ${CHIBIOS_CONTRIB}/os/hal/ports/STM32/LLD/CRCv1 \
                       ${CHIBIOS_CONTRIB}/os/various \

ALLINC  += ${PLATFORMINC_CONTRIB}

ALLCSRC += $(HALSRC_CONTRIB)
ALLINC  += ${CHIBIOS_CONTRIB}/os/hal/include
# C++ sources that can be compiled in ARM or THUMB mode depending on the global
# setting.
CPPSRC = $(ALLCPPSRC) \
         $(LIBOPENINVCPP) \
         hw_layer/hwinit.cpp \
         sine_core.cpp \
         stm32-sine.cpp \
         main.cpp

# List ASM source files here.
ASMSRC = $(ALLASMSRC)

# List ASM with preprocessor source files here.
ASMXSRC = $(ALLXASMSRC)

HW_LAYER_INC = $(PROJECT_DIR)/hw_layer 

# Inclusion directories.
INCDIR = $(CONFDIR) $(ALLINC) $(TESTINC) \
          $(HW_LAYER_INC) \
          include \
          libopeninv/include \
          # libopencm3/include/libopencm3/stm32

# Define C warning options here.
CWARN = -Wall -Wextra -Wundef -Wstrict-prototypes

# Define C++ warning options here.
CPPWARN = -Wall -Wextra -Wundef

ifeq ($(MCU),)
MCU := cortex-m3
endif

$(info PROJECT_BOARD:  $(PROJECT_BOARD))
$(info PROJECT_CPU:    $(PROJECT_CPU))
$(info MCU:            $(MCU))
$(info CONFDIR:        $(CONFDIR))
$(info LDSCRIPT:       $(LDSCRIPT))
$(info HW_LAYER_INC:   $(HW_LAYER_INC))
$(info CPU_HWLAYER:    $(CPU_HWLAYER))
$(info HALSRC_CONTRIB: $(HALSRC_CONTRIB))
$(info board.c: $(BOARDS_DIR)/$(PROJECT_BOARD)/board.c)

#
# Project, target, sources and paths
##############################################################################

##############################################################################
# Start of user section
#

# List all user C define here, like -D_DEBUG=1
UDEFS = -DCONTROL=CTRL_$(CONTROL) -DCTRL_SINE=0 -DCTRL_FOC=1

# Define ASM defines here
UADEFS =

# List all user directories here
UINCDIR =

# List the user directory to look for the libraries here
ULIBDIR =

# List all user libraries here
ULIBS =

#
# End of user section
##############################################################################

##############################################################################
# Common rules
#

RULESPATH = $(CHIBIOS)/os/common/startup/ARMCMx/compilers/GCC/mk
include $(RULESPATH)/arm-none-eabi.mk
include $(RULESPATH)/rules.mk

#
# Common rules
##############################################################################

##############################################################################
# Custom rules
#

#
# Custom rules
##############################################################################
