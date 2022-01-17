#!/bin/bash

export PROJECT_BOARD=prius_G2
export PROJECT_CPU=ARCH_STM32F1
export EXTRA_PARAMS="-DSHORT_BOARD_NAME=prius_G2_f1"
export MCU=cortex-m3
# export CPU_HWLAYER=ports/stm32/stm32f1/

export CONTROL=FOC
export DEBUG_LEVEL_OPT="-O0 -ggdb -g"

bash ../common_make.sh
