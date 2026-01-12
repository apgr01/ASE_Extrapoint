/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           IRQ_RIT.c
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        functions to manage T0 and T1 interrupts
** Correlated files:    RIT.h
**--------------------------------------------------------------------------------------------------------
*********************************************************************************************************/
#include "LPC17xx.h"
#include "RIT.h"
#include "../led/led.h"
#include "../sample.h"
#include "../game.h"

/* User Imports */

//#include "../main/user_RIT.h"

/* Variabili Globali Gestione De-Bouncing */
	
volatile int down_0 = 0;
volatile int down_1 = 0;
volatile int down_2 = 0;
volatile int toRelease_down_0 = 0;
volatile int toRelease_down_1 = 0;
volatile int toRelease_down_2 = 0;

volatile int J_up = 0;
volatile int J_down = 0;
volatile int J_right = 0;
volatile int J_left = 0;
volatile int J_click = 0;
volatile int J_up_left = 0;
volatile int J_up_right = 0;
volatile int J_down_left = 0;
volatile int J_down_right = 0;

	/* Variabili Globali */

int const long_press_count_1 = 0;		// => count = x / 50ms ; where x = time long press
//int const long_press_count_2 = 0;  


/******************************************************************************
** Function name:		RIT_IRQHandler
**
** Descriptions:		REPETITIVE INTERRUPT TIMER handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/
void RIT_IRQHandler(void)
{
    /* ---------------- INT0 ---------------- */
    if (down_0 != 0) {
        down_0++;

        if ((LPC_GPIO2->FIOPIN & (1 << 10)) == 0) {   // pulsante premuto
            if (down_0 == 2) {
                toRelease_down_0 = 1;
            }
        } else {                                     // pulsante rilasciato
            toRelease_down_0 = 0;
            down_0 = 0;

            NVIC_EnableIRQ(EINT0_IRQn);
            LPC_PINCON->PINSEL4 |= (1 << 20);        // ripristina EINT0
        }
    }

    /* ---------------- KEY1 ---------------- */
    if (down_1 != 0) {
        down_1++;

        if ((LPC_GPIO2->FIOPIN & (1 << 11)) == 0) {   // pulsante premuto
            if (down_1 == 2) {
                on_key1_pressed(); // handler key 1
                toRelease_down_1 = 1;
            }
        } else {                                     // pulsante rilasciato
            toRelease_down_1 = 0;
            down_1 = 0;

            NVIC_EnableIRQ(EINT1_IRQn);
            LPC_PINCON->PINSEL4 |= (1 << 22);        // ripristina EINT1
        }
    }

    /* ---------------- KEY2 ---------------- */
    if (down_2 != 0) {
        down_2++;

        if ((LPC_GPIO2->FIOPIN & (1 << 12)) == 0) {   // pulsante premuto
            if (down_2 == 2) {
                hard_drop_mode = 1; // attivo hard drop mode
                toRelease_down_2 = 1;
            }
        } else {                                     // pulsante rilasciato
            toRelease_down_2 = 0;
            down_2 = 0;

            NVIC_EnableIRQ(EINT2_IRQn);
            LPC_PINCON->PINSEL4 |= (1 << 24);        // ripristina EINT2
        }
    }

    /* ---------------- JOYSTICK ---------------- */

    J_click = ((LPC_GPIO1->FIOPIN & (1 << 25)) == 0);
    J_down  = ((LPC_GPIO1->FIOPIN & (1 << 26)) == 0);
    J_left  = ((LPC_GPIO1->FIOPIN & (1 << 27)) == 0);
    J_right = ((LPC_GPIO1->FIOPIN & (1 << 28)) == 0);
    J_up    = ((LPC_GPIO1->FIOPIN & (1 << 29)) == 0);

    /* Clear interrupt flag */
    LPC_RIT->RICTRL |= 0x01;
}
