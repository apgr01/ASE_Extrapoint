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
	
	unsigned char UP_LEFT_activated = 0;
	unsigned char UP_RIGHT_activated = 0;
	unsigned char DOWN_LEFT_activated = 0;
	unsigned char DOWN_RIGHT_activated = 0;
	
	/* INT0 */
	
	if(down_0 !=0) {			/* INT0 */
		down_0++;
		if((LPC_GPIO2->FIOPIN & (1<<10)) == 0){ /* button premuto */
			switch(down_0) {
				case 2:				
					// short press
				  	// your_code	
					toRelease_down_0 = 1;
					break;
				case long_press_count_1:					
					// your code here (for long press)				
					break;
				default:
					break;
			}
		}
		else {	/* button released */
			if(toRelease_down_0){
				//add code to manage release.
				toRelease_down_0=0;
			}
			down_0=0;			
			NVIC_EnableIRQ(EINT0_IRQn);					 /* disable Button interrupts		 */
			LPC_PINCON->PINSEL4    |= (1 << 20);     			 /* External interrupt 0 pin selection   */
		}
	} 	// end INT0

	///////////////////////////////////////////////////////////////////
	
/* KEY1 */
	if(down_1 !=0) {
		down_1++;
		if((LPC_GPIO2->FIOPIN & (1<<11)) == 0){ /* button premuto */
			switch(down_1){
				case 2:
					// --- MODIFICA QUI ---
					// Appena il tasto è confermato premuto, chiamo la logica di gioco
					on_key1_pressed(); 
					// --------------------
					
					toRelease_down_1=1;
					break;
				case long_press_count_1:
					break;
				default:
					break;
			}
		}
		else {	/* button released */
			if(toRelease_down_1){
				toRelease_down_1=0;
			}			
			down_1=0;	
			NVIC_EnableIRQ(EINT1_IRQn);
			LPC_PINCON->PINSEL4 |= (1 << 22);
		}
	}
	
	///////////////////////////////////////////////////////////////////
	
/* KEY2 */
	if(down_2 !=0) {			
		down_2++;
		// Controlla se il tasto P2.12 è ancora premuto
		if((LPC_GPIO2->FIOPIN & (1<<12)) == 0){ 
			switch(down_2){
				case 2:
					// --- QUI SCATTA L'AZIONE (Short Press) ---
					
					hard_drop_mode = 1;  // <--- AGGIUNGI QUESTA RIGA
					
					toRelease_down_2=1;
					break;
				case long_press_count_1:
					// Codice per pressione lunga (non serve ora)
					break;
				default:
					break;
			}
		}
		else {	/* Tasto rilasciato */
			if(toRelease_down_2){
				toRelease_down_2=0;
			}	
			down_2=0;		
			NVIC_EnableIRQ(EINT2_IRQn);	 // Riabilita l'interrupt per la prossima volta
			LPC_PINCON->PINSEL4 |= (1 << 24); 
		}
	}
	///////////////////////////////////////////////////////////////////
// --- GESTIONE JOYSTICK (Diretta e Veloce) ---

// SELECT (P1.25)
if((LPC_GPIO1->FIOPIN & (1<<25)) == 0) {	
    J_click = 1;
} else {
    J_click = 0;
}

// DOWN (P1.26)
if((LPC_GPIO1->FIOPIN & (1<<26)) == 0) {	
    J_down = 1;
} else {
    J_down = 0;
}

// LEFT (P1.27)
if((LPC_GPIO1->FIOPIN & (1<<27)) == 0) {	
    J_left = 1;
} else {
    J_left = 0;
}

// RIGHT (P1.28)
if((LPC_GPIO1->FIOPIN & (1<<28)) == 0) {	
    J_right = 1;
} else {
    J_right = 0;
}

// UP (P1.29)
if((LPC_GPIO1->FIOPIN & (1<<29)) == 0) {	
    J_up = 1;
} else {
    J_up = 0;
}	
	//reset_RIT(); se ci sono cose strane come il rit che si ferma
	LPC_RIT->RICTRL |= 0x1;	/* clear interrupt flag */
	
	return;
}

/******************************************************************************
**                            End Of File
******************************************************************************/
