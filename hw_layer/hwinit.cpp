#include "hwdefs.h"
#include "hwinit.h"
#include "hal.h"

#ifdef STM32F1XX
// These have an 87.5% sample point
#define CAN_BTR_100 (CAN_BTR_SJW(1) | CAN_BTR_BRP(20) | CAN_BTR_TS1(15) | CAN_BTR_TS2(2))
#define CAN_BTR_250 (CAN_BTR_SJW(1) | CAN_BTR_BRP(8) | CAN_BTR_TS1(15) | CAN_BTR_TS2(2))
#define CAN_BTR_500 (CAN_BTR_SJW(1) | CAN_BTR_BRP(4)  | CAN_BTR_TS1(15) | CAN_BTR_TS2(2))
#define CAN_BTR_1k0 (CAN_BTR_SJW(1) | CAN_BTR_BRP(2)  | CAN_BTR_TS1(15) | CAN_BTR_TS2(2))
#endif

static const CANConfig canConfig100 = {
CAN_MCR_ABOM | CAN_MCR_AWUM | CAN_MCR_TXFP,
CAN_BTR_100 };

static const CANConfig canConfig250 = {
CAN_MCR_ABOM | CAN_MCR_AWUM | CAN_MCR_TXFP,
CAN_BTR_250 };

static const CANConfig canConfig500 = {
CAN_MCR_ABOM | CAN_MCR_AWUM | CAN_MCR_TXFP,
CAN_BTR_500 };

static const CANConfig canConfig1000 = {
CAN_MCR_ABOM | CAN_MCR_AWUM | CAN_MCR_TXFP,
CAN_BTR_1k0 };


uint16_t pwmio_setup(bool activeLow)
{   
   uint8_t outputMode = activeLow ? PAL_MODE_INPUT : PAL_MODE_OUTPUT_PUSHPULL;
   uint16_t actualPattern = palReadPad(PAL_PORT(GPIOA), PAL_PAD(8 | 9 | 10)) | palReadPad(PAL_PORT(GPIOB), PAL_PAD(13 | 14 | 15));

   palSetGroupMode(GPIOA, PAL_PORT_BIT(8 | 9 | 10), 0U, outputMode);
   palSetGroupMode(GPIOB, PAL_PORT_BIT(13 | 14 | 15), 0U, outputMode);

   return actualPattern;
}

void initCan() {

    canStart(&CAND1, &canConfig500);
}

void hwinit() {

    palSetPadMode(GPIOC, 12, PAL_MODE_OUTPUT_PUSHPULL); // hard coded for testing

    initCan();
    crcInit();

}