#!/bin/bash

export PROJECT_BOARD=tesla_SDU
export PROJECT_CPU=ARCH_STM32F1
export EXTRA_PARAMS="-DSHORT_BOARD_NAME=teslaSDU_f1"
# export CPU_HWLAYER=ports/stm32/stm32f1/

export CONTROL=SINE
# export DEBUG_LEVEL_OPT="-O0 -ggdb -g"

bash ../common_make.sh
