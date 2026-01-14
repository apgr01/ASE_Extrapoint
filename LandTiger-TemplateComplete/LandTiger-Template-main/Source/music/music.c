#include "music.h"
#include "LPC17xx.h"

static int current_note_index = 0;
static volatile int is_playing = 0;

// Volume (0 - 1023). Modifica qui se vuoi alzare/abbassare.
volatile int currentVolume = 50; 

/* --- TEMA COMPLETO TETRIS (Korobeiniki) --- */
NOTE song_tetris[] = {
    // ============ PARTE A (Melodia Principale) ============
    
    // Battuta 1
    {e5, time_semiminima}, {b4, time_croma}, {c5, time_croma}, {d5, time_semiminima}, {c5, time_croma}, {b4, time_croma},
    // Battuta 2
    {a4, time_semiminima}, {a4, time_croma}, {c5, time_croma}, {e5, time_semiminima}, {d5, time_croma}, {c5, time_croma},
    // Battuta 3
    {b4, time_semiminima}, {b4, time_croma}, {c5, time_croma}, {d5, time_semiminima}, {e5, time_semiminima},
    // Battuta 4
    {c5, time_semiminima}, {a4, time_semiminima}, {a4, time_semiminima}, {pause, time_semiminima},

    // Ripetizione Parte A (Opzionale, ma comune nel gioco)
    // Battuta 5
    {e5, time_semiminima}, {b4, time_croma}, {c5, time_croma}, {d5, time_semiminima}, {c5, time_croma}, {b4, time_croma},
    // Battuta 6
    {a4, time_semiminima}, {a4, time_croma}, {c5, time_croma}, {e5, time_semiminima}, {d5, time_croma}, {c5, time_croma},
    // Battuta 7
    {b4, time_semiminima}, {b4, time_croma}, {c5, time_croma}, {d5, time_semiminima}, {e5, time_semiminima},
    // Battuta 8
    {c5, time_semiminima}, {a4, time_semiminima}, {a4, time_semiminima}, {pause, time_semiminima},

    // ============ PARTE B (Ponte Alto) ============
    
    // Battuta 9
    {d5, time_minima}, {f5, time_croma}, {a5, time_semiminima}, {g5, time_croma}, {f5, time_croma},
    // Battuta 10
    {e5, time_semiminima}, {e5, time_croma}, {c5, time_croma}, {e5, time_semiminima}, {d5, time_croma}, {c5, time_croma},
    // Battuta 11
    {b4, time_semiminima}, {b4, time_croma}, {c5, time_croma}, {d5, time_semiminima}, {e5, time_semiminima},
    // Battuta 12
    {c5, time_semiminima}, {a4, time_semiminima}, {a4, time_semiminima}, {pause, time_semiminima},

    // Ripetizione Parte B
    // Battuta 13
    {d5, time_minima}, {f5, time_croma}, {a5, time_semiminima}, {g5, time_croma}, {f5, time_croma},
    // Battuta 14
    {e5, time_semiminima}, {e5, time_croma}, {c5, time_croma}, {e5, time_semiminima}, {d5, time_croma}, {c5, time_croma},
    // Battuta 15
    {b4, time_semiminima}, {b4, time_croma}, {c5, time_croma}, {d5, time_semiminima}, {e5, time_semiminima},
    // Battuta 16 (Finale Loop)
    {c5, time_semiminima}, {a4, time_semiminima}, {a4, time_semiminima}, {pause, time_semiminima}
};

#define SONG_LENGTH (sizeof(song_tetris) / sizeof(NOTE))

/* ... (Il resto delle funzioni playNote, music_init, ecc. resta identico a prima) ... */
void playNote(NOTE note) {
    if (note.freq != pause) {
        LPC_TIM2->MR0 = note.freq; 
        LPC_TIM2->TCR = 3;         
        LPC_TIM2->TCR = 1;         
    } else {
        LPC_TIM2->TCR = 0;         
    }
    LPC_TIM1->MR0 = note.duration; 
    LPC_TIM1->TCR = 3;             
    LPC_TIM1->TCR = 1;             
}

void music_init(void) {
    // Configura P0.26 come AOUT (DAC)
    LPC_PINCON->PINSEL1 &= ~(3 << 20); 
    LPC_PINCON->PINSEL1 |= (2 << 20);  
    current_note_index = 0;
    is_playing = 0;
}

void music_start(void) {
    current_note_index = 0;
    is_playing = 1;
    NVIC_EnableIRQ(TIMER1_IRQn);
    NVIC_EnableIRQ(TIMER2_IRQn);
    playNote(song_tetris[0]);
}

void music_stop(void) {
    is_playing = 0;
    LPC_TIM1->TCR = 0; 
    LPC_TIM2->TCR = 0; 
}

void music_pause_resume(int pause_flag) {
    if (pause_flag) {
        LPC_TIM1->TCR &= ~1;
        LPC_TIM2->TCR &= ~1;
    } else {
        if (is_playing) {
            LPC_TIM1->TCR |= 1;
            if (song_tetris[current_note_index].freq != pause) {
                LPC_TIM2->TCR |= 1;
            }
        }
    }
}

void music_player_tick(void) {
    if (!is_playing) return;
    current_note_index++;
    if (current_note_index >= SONG_LENGTH) current_note_index = 0; 
    playNote(song_tetris[current_note_index]);
}