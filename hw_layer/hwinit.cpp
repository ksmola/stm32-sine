#include "hwdefs.h"
#include "hwinit.h"
#include "hal.h"



uint16_t pwmio_setup(bool activeLow)
{   
   uint8_t outputMode = activeLow ? PAL_MODE_INPUT : PAL_MODE_OUTPUT_PUSHPULL;
   uint16_t actualPattern = palReadPad(PAL_PORT(GPIOA), PAL_PAD(8 | 9 | 10)) | palReadPad(PAL_PORT(GPIOB), PAL_PAD(13 | 14 | 15));

   palSetGroupMode(GPIOA, PAL_PORT_BIT(8 | 9 | 10), 0U, outputMode);
   palSetGroupMode(GPIOB, PAL_PORT_BIT(13 | 14 | 15), 0U, outputMode);

   return actualPattern;
}


void hwinit() {

    palSetPadMode(GPIOC, 12, PAL_MODE_OUTPUT_PUSHPULL); // hard coded for testing

    crcInit();

}