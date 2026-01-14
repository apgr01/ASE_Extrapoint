/*----------------------------------------------------------------------------
 * Name:    sample.c
 * Purpose: to control led through debounced buttons and Joystick
 *        	- key1 switches on the led at the left of the current led on, 
 *		- it implements a circular led effect,
 * 		- joystick UP function returns to initial configuration (led11 on) .
 * Note(s): this version supports the LANDTIGER Emulator
 * Author: 	Paolo BERNARDI - PoliTO - last modified 15/12/2020
 *----------------------------------------------------------------------------
 *
 * This software is supplied "AS IS" without warranties of any kind.
 *
 * Copyright (c) 2017 Politecnico di Torino. All rights reserved.
 *----------------------------------------------------------------------------*/
                  
#include <stdio.h>
#include "LPC17xx.h"                    /* LPC17xx definitions                */
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
extern uint8_t ScaleFlag; // <- ScaleFlag needs to visible in order for the emulator to find the symbol (can be placed also inside system_LPC17xx.h but since it is RO, it needs more work)
#endif

/*
unsigned char startState = 0xAA;
unsigned char currentState = 0xAA; //0b101010
unsigned char taps = 0x41; //01000001
*/

/*----------------------------------------------------------------------------
  Main Program
 *----------------------------------------------------------------------------*/

int main(void) {

    /* Inizializzazione di sistema e display */
    SystemInit();
    LCD_Initialization();
    LCD_Clear(T_Black);

    /* Inizializzazione input */
    joystick_init();
    BUTTON_init();
	
		ADC_init();
		music_init();

    /* RIT: gestione input (debounce + joystick) */
    init_RIT(0x10625A0);
    enable_RIT();

    /* Timer 0: clock del gioco */
    init_timer(0, 0, 0, 3, 0x00098968);
    enable_timer(0);
    NVIC_EnableIRQ(TIMER0_IRQn);

    /* Avvio del gioco */
    game_init();

    /* Loop principale */
    while (1) {
        __ASM("wfi");       // CPU in sleep, risvegliata dagli interrupt
    }
}