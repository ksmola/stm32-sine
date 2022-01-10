#!/bin/bash

SCRIPT_NAME="common_make.sh"
echo "Entering $SCRIPT_NAME"

# build using env variables
cd ../../..
make -j$(nproc) -r

if [ -e build/stm32-sine.hex ]; then
    echo "Built successful by $SCRIPT_NAME with $PROJECT_BOARD $DEBUG_LEVEL_OPT and $EXTRA_PARAMS"
else 
    echo "FAILED to compile by $SCRIPT_NAME with $PROJECT_BOARD $DEBUG_LEVEL_OPT and $EXTRA_PARAMS"
fi 

ls -l build
