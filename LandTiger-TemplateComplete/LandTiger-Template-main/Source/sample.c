#include <stdio.h>
#include "LPC17xx.h"
#include "led/led.h"
#include "button_EXINT/button.h"
#include "timer/timer.h"
#include "RIT/RIT.h"
#include "joystick/joystick.h"
#include "sample.h"
#include "game.h"
#include "adc/adc.h"
#include "music/music.h"

#ifdef SIMULATOR
extern uint8_t ScaleFlag;
#endif

int main(void) {
    /* 1. Inizializzazione Hardware Base */
    SystemInit();
    LCD_Initialization();
    LCD_Clear(T_Black); // Pulisce lo schermo

    joystick_init();
    BUTTON_init();
    ADC_init();
    music_init(); // Configura il pin dello speaker

    /* 2. ACCENSIONE MANUALE TIMER (Per evitare crash se init_timer non supporta T1/T2) */
    // Bit 1=TIM0, Bit 2=TIM1, Bit 22=TIM2
    LPC_SC->PCONP |= (1 << 1) | (1 << 2) | (1 << 22);
    
    // Resetta i clock dei timer (PCLK_TIMER = CCLK/4)
    LPC_SC->PCLKSEL0 &= ~((3<<2) | (3<<4)); 
    LPC_SC->PCLKSEL1 &= ~(3<<12);

    /* 3. Configurazione TIMER */
    // TIMER 0: Gioco (40Hz)
    init_timer(0, 0, 0, 3, 0x00098968);
    
    // TIMER 1: Musica Durata (Valore base, poi gestito da music.c)
    // Se init_timer non supporta il canale 1, le righe PCONP sopra ci salvano
    LPC_TIM1->PR = 0; 
    LPC_TIM1->MCR = 3; // Interrupt + Reset on Match
    
    // TIMER 2: Musica Frequenza
    LPC_TIM2->PR = 0;
    LPC_TIM2->MCR = 3;

    /* 4. Configurazione Priorità Interrupt */
    // IMPORTANTE: Timer 0 e RIT devono avere la stessa priorità (1)
    NVIC_SetPriority(RIT_IRQn, 1);
    NVIC_SetPriority(TIMER0_IRQn, 1); 
    
    // Musica a priorità più bassa (2)
    NVIC_SetPriority(TIMER1_IRQn, 2);
    NVIC_SetPriority(TIMER2_IRQn, 2);
    
    // Abilita IRQ Timer nel NVIC
    NVIC_EnableIRQ(TIMER0_IRQn);
    // (Timer 1 e 2 vengono abilitati in music_start, ma per sicurezza li abilitiamo)
    NVIC_EnableIRQ(TIMER1_IRQn);
    NVIC_EnableIRQ(TIMER2_IRQn);

    /* 5. Avvio Logica */
    init_RIT(0x10625A0);
    enable_RIT();
    
    // Assicuriamoci che i timer musicali siano spenti
    disable_timer(1);
    disable_timer(2);

    /* 6. Disegna l'interfaccia (Game Init) */
    // Lo facciamo PRIMA di abilitare il Timer 0, così non ci sono conflitti video
    game_init();

    /* 7. Start Game Loop */
    // Ora che è tutto disegnato, accendiamo il motore del gioco
    enable_timer(0);

    while (1) {
        __ASM("wfi");
    }
}