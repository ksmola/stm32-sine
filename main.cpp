/*
 * This file is part of the stm32-sine project.
 *
 * Copyright (C) 2010 Johannes Huebner <contact@johanneshuebner.com>
 * Copyright (C) 2010 Edward Cheeseman <cheesemanedward@gmail.com>
 * Copyright (C) 2009 Uwe Hermann <uwe@hermann-uwe.de>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include <stdint.h>
#include "hal.h"
#include "stm32-sine.h"

int main(void)
{

   /*
	 * ChibiOS/RT initialization
	 */
   halInit();
   chSysInit();

   // extern const TERM_CMD TermCmds[];
   // initRtc();
   // clock_setup();
   // rtc_setup();
   // hwRev = io_setup();
   // write_bootloader_pininit();
   // tim_setup();
   // nvic_setup();
   // //Encoder::Reset();
   // parm_load();
   // ErrorMessage::SetTime(1);
   // Param::SetInt(Param::pwmio, pwmio_setup(Param::GetBool(Param::pwmpol)));

   // MotorVoltage::SetMaxAmp(SineCore::MAXAMP);
   // PwmGeneration::SetCurrentOffset(2048, 2048);

   // Stm32Scheduler s(hwRev == HW_BLUEPILL ? TIM4 : TIM2); //We never exit main so it's ok to put it on stack
   // scheduler = &s;
   // Can c(CAN1, (Can::baudrates)Param::GetInt(Param::canspeed));
   // can = &c;
   // VehicleControl::SetCan(can);

   // s.AddTask(Ms1Task, 1);
   // s.AddTask(Ms10Task, 10);
   // s.AddTask(Ms100Task, 100);

   // DigIo::prec_out.Set();

   // Terminal t(USART3, TermCmds);
   // terminal = &t;

   // if (hwRev == HW_REV1)
   //    t.DisableTxDMA();

   // UpgradeParameters();
   // parm_Change(Param::PARAM_LAST);

   // while(1)
   //    t.Run();

   return 0;
}

