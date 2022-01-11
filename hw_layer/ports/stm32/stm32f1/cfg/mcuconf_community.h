/*
 * CRC driver system settings.
 */
#define STM32_CRC_USE_CRC1                  TRUE
#define STM32_CRC_CRC1_DMA_IRQ_PRIORITY     1
#define STM32_CRC_CRC1_DMA_PRIORITY         2
#define STM32_CRC_CRC1_DMA_STREAM           STM32_DMA1_STREAM2

#define CRCSW_USE_CRC1                      FALSE
#define CRCSW_CRC32_TABLE                   TRUE
#define CRCSW_CRC16_TABLE                   TRUE
#define CRCSW_PROGRAMMABLE                  TRUE