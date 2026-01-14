#include "music.h"
#include "LPC17xx.h"

// Variabili Stato Player
static int current_note_index = 0;
static volatile int is_playing = 0;

// Variabili Stato Effetto Sonoro
static volatile int sfx_active = 0;     // 1 se stiamo suonando l'effetto
static int sfx_note_index = 0;

// Volume (0 - 1023)
volatile int currentVolume = 50; 

/* --- EFFETTO SONORO: LINE CLEAR (Arpeggio Veloce) --- */
NOTE sfx_clear[] = {
    {c6, time_biscroma}, // Note velocissime e acute
    {e6, time_biscroma},
    {g6, time_biscroma},
    {c7, time_semicroma}, 
    {pause, time_biscroma} // Pausa tecnica finale
};
#define SFX_LENGTH (sizeof(sfx_clear) / sizeof(NOTE))

/* --- TEMA COMPLETO TETRIS (A-A-B-B) --- */
NOTE song_tetris[] = {
    // === PARTE A (1) ===
    {e5, time_semiminima_p}, {b4, time_croma}, {c5, time_croma}, {d5, time_semiminima}, {c5, time_croma}, {b4, time_croma},
    {a4, time_semiminima}, {a4, time_croma}, {c5, time_croma}, {e5, time_semiminima}, {d5, time_croma}, {c5, time_croma},
    {b4, time_semiminima_p}, {c5, time_croma}, {d5, time_semiminima}, {e5, time_semiminima},
    {c5, time_semiminima}, {a4, time_semiminima}, {a4, time_semiminima}, {pause, time_semiminima},

    // === PARTE B (1) ===
    {d5, time_semiminima_p}, {f5, time_croma}, {a5, time_semiminima}, {g5, time_croma}, {f5, time_croma},
    {e5, time_semiminima_p}, {c5, time_croma}, {e5, time_semiminima}, {d5, time_croma}, {c5, time_croma},
    {b4, time_semiminima}, {b4, time_croma}, {c5, time_croma}, {d5, time_semiminima}, {e5, time_semiminima},
    {c5, time_semiminima}, {a4, time_semiminima}, {a4, time_semiminima}, {pause, time_semiminima}
};

#define SONG_LENGTH (sizeof(song_tetris) / sizeof(NOTE))

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
    LPC_PINCON->PINSEL1 &= ~(3 << 20); 
    LPC_PINCON->PINSEL1 |= (2 << 20);  
    current_note_index = 0;
    is_playing = 0;
    sfx_active = 0;
}

void music_start(void) {
    current_note_index = 0;
    is_playing = 1;
    sfx_active = 0; // Reset effetti
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
            // Se stiamo riprendendo, controlliamo se eravamo in un effetto o musica
            if (sfx_active) {
                if (sfx_clear[sfx_note_index].freq != pause) LPC_TIM2->TCR |= 1;
            } else {
                if (song_tetris[current_note_index].freq != pause) LPC_TIM2->TCR |= 1;
            }
        }
    }
}

/* --- FUNZIONE CHIAMATA DA GAME.C --- */
void music_play_clear_sfx(void) {
    if (!is_playing) return; // Se muto, niente effetto
    
    sfx_active = 1;         // Attiva modalità effetto
    sfx_note_index = 0;     // Reset indice effetto
    playNote(sfx_clear[0]); // Suona subito la prima nota
}

/* --- GESTORE DEL TICK --- */
void music_player_tick(void) {
    if (!is_playing) return;
    
    if (sfx_active) {
        // --- MODALITÀ EFFETTO ---
        sfx_note_index++;
        if (sfx_note_index >= SFX_LENGTH) {
            // Effetto finito!
            sfx_active = 0;
            // Riprendi la musica da dove eravamo
            playNote(song_tetris[current_note_index]); 
        } else {
            // Prossima nota effetto
            playNote(sfx_clear[sfx_note_index]);
        }
    } else {
        // --- MODALITÀ NORMALE (Musica) ---
        current_note_index++;
        if (current_note_index >= SONG_LENGTH) current_note_index = 0; 
        playNote(song_tetris[current_note_index]);
    }
}