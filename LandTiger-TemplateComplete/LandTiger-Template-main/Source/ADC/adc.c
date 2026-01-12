#include "adc.h"

void ADC_init(void) {
    // 1. Accendi il modulo ADC (Bit 12 di PCONP)
    LPC_SC->PCONP |= (1 << 12);

    // 2. Seleziona la funzione AD0.5 per il pin P1.31 (Funzione 11 -> 3)
    // Il potenziometro sulla Landtiger è collegato a P1.31 (AD0.5)
    LPC_PINCON->PINSEL3 |= (3 << 30); 

    // 3. Configura ADCR (Control Register)
    // Bit 5: Select AD0.5
    // Bit 8-15: Clock divisor (per stare sotto 13MHz). PCLK=25MHz. Div=2 -> 12.5MHz
    // Bit 21: PDN (Power Down) = 1 (Operational)
    LPC_ADC->ADCR = (1 << 5) | (4 << 8) | (1 << 21);
}

void ADC_start_conversion(void) {
    // Start conversion now (Bit 24)
    LPC_ADC->ADCR |= (1 << 24);
}

uint16_t ADC_read(void) {
    // Controlla se il bit di DONE (31) è 1
    if (LPC_ADC->ADDR5 & 0x80000000) {
        // Estrai il risultato (Bit 4-15)
        return (LPC_ADC->ADDR5 >> 4) & 0xFFF;
    }
    return 0; // O gestisci errore/valore precedente
}