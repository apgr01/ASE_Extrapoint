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
    SystemInit();  
    LCD_Initialization();
    LCD_Clear(T_Black); 


		joystick_init(); 
		BUTTON_init();


    init_RIT(0x10625A0); // 25ms clock
    enable_RIT();         // Avvia il RIT

    // ------------------------------------------------
    // 3. INIZIALIZZAZIONE TIMER 0 (Engine di Gioco)
    // ------------------------------------------------
    // Questo è il motore veloce che abbiamo settato prima
    init_timer(0, 0, 0, 3, 0x00098968); 
    enable_timer(0);
    
    // Abilita interruzione Timer 0 (FONDAMENTALE)
    NVIC_EnableIRQ(TIMER0_IRQn);

    // ------------------------------------------------
    // 4. AVVIO GIOCO
    // ------------------------------------------------
    game_init();
    
    while(1) {
        // Lascia pure wfi, ora non darà fastidio perché
        // abbiamo due timer che svegliano la CPU costantemente
        __ASM("wfi");
    }
}