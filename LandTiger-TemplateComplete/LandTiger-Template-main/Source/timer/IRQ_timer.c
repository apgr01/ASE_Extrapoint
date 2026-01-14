#include "LPC17xx.h"
#include "timer.h"
#include "../game.h"
#include "../music/music.h"
// Includiamo l'ADC se vuoi controllare il volume col potenziometro (opzionale)
#include "../adc/adc.h" 

extern unsigned short AD_current; // Variabile del potenziometro

// TIMER 0: Gioco
void TIMER0_IRQHandler (void)
{
    if(LPC_TIM0->IR & 1) { 
        game_update();
        LPC_TIM0->IR = 1;
    }
}

// TIMER 1: Durata Musica
void TIMER1_IRQHandler (void)
{
    if(LPC_TIM1->IR & 1) { 
        music_player_tick(); 
        LPC_TIM1->IR = 1;
    }
}

// TIMER 2: Speaker Audio (DAC)
void TIMER2_IRQHandler (void)
{
    if(LPC_TIM2->IR & 1) { // MR0
        static int speaker_state = 0;
        
        // GESTIONE VOLUME
        // Opzione A: Volume fisso (definito in music.c come currentVolume = 200)
        int volume_to_use = currentVolume;
        
        /* Opzione B: Volume col Potenziometro? 
           ATTENZIONE: Il potenziometro controlla già la velocità.
           Se vuoi che controlli ANCHE il volume, de-commenta la riga sotto.
           Nota: Gioco veloce = Volume alto.
        */
        // volume_to_use = (AD_current >> 2); // Scala 4096 -> 1024
        
        if (speaker_state == 0) {
            // DACR: bit 6-15 contengono il valore (0-1023)
            LPC_DAC->DACR = (volume_to_use << 6); 
            speaker_state = 1;
        } else {
            // Mettiamo a 0 (Silenzio)
            LPC_DAC->DACR = 0; 
            speaker_state = 0;
        }
        
        LPC_TIM2->IR = 1;
    }
}

void TIMER3_IRQHandler (void) { LPC_TIM3->IR = 1; }