#ifndef ADC_H
#define ADC_H
#include "LPC17xx.h"

void ADC_init(void);
void ADC_start_conversion(void);
uint16_t ADC_read(void);

#endif