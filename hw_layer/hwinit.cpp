#include "ch.h"
#include "hwdefs.h"
#include "hwinit.h"
#include "params.h"
#include "hal.h"


#ifdef STM32F1XX
// These have an 87.5% sample point
#define CAN_BTR_100 (CAN_BTR_SJW(0) | CAN_BTR_BRP(20) | CAN_BTR_TS1(15) | CAN_BTR_TS2(2))
#define CAN_BTR_250 (CAN_BTR_SJW(0) | CAN_BTR_BRP(8) | CAN_BTR_TS1(15) | CAN_BTR_TS2(2))
#define CAN_BTR_500 (CAN_BTR_SJW(0) | CAN_BTR_BRP(8)  | CAN_BTR_TS1(3) | CAN_BTR_TS2(2))
#define CAN_BTR_800 (CAN_BTR_SJW(0) | CAN_BTR_BRP(8)  | CAN_BTR_TS1(3) | CAN_BTR_TS2(2))
#define CAN_BTR_1k0 (CAN_BTR_SJW(0) | CAN_BTR_BRP(4)  | CAN_BTR_TS1(3) | CAN_BTR_TS2(2))
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

static const CANConfig canConfig800 = {
CAN_MCR_ABOM | CAN_MCR_AWUM | CAN_MCR_TXFP,
CAN_BTR_800 };

static const CANConfig canConfig1000 = {
CAN_MCR_ABOM | CAN_MCR_AWUM | CAN_MCR_TXFP,
CAN_BTR_1k0 };


uint16_t pwmio_setup(bool activeLow) {   
   uint8_t outputMode = activeLow ? PAL_MODE_RESET : PAL_MODE_STM32_ALTERNATE_PUSHPULL;
   uint16_t actualPattern = palReadGroup(GPIOA, PAL_PORT_BIT(8) | PAL_PORT_BIT(9) | PAL_PORT_BIT(10), 0) | palReadGroup(GPIOB, PAL_PORT_BIT(13) | PAL_PORT_BIT(14) | PAL_PORT_BIT(15), 0);

   palSetGroupMode(GPIOA, PAL_PORT_BIT(8) | PAL_PORT_BIT(9) | PAL_PORT_BIT(10), 0, outputMode);   
   palSetGroupMode(GPIOB, PAL_PORT_BIT(13) | PAL_PORT_BIT(14) | PAL_PORT_BIT(15), 0, outputMode);

   return actualPattern;
}

const CANConfig *getCanConfig(int baudrate) {
    switch (baudrate)
    {
    case 0:
        return &canConfig250;
        break;
    case 1:
        return &canConfig500;
        break;
    case 2:
        return &canConfig800;
        break;
    case 3:
        return &canConfig1000;
        break;
    default:
        return &canConfig500;
        break;
    }
}

void initCan(int baudrate) {
    canStart(&CAND1, getCanConfig(baudrate));
}

/**
* Initializes Hardware
*/
void hwinit() {
    palSetPadMode(GPIOC, 12, PAL_MODE_OUTPUT_PUSHPULL); // hard coded for testing

    initCan(Param::GetInt(Param::canspeed));

    Param::SetInt(Param::pwmio, pwmio_setup(Param::GetBool(Param::pwmpol)));


    // crcInit();
}