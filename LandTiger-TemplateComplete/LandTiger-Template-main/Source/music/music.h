#ifndef MUSIC_H
#define MUSIC_H

#include "LPC17xx.h"

// --- CONFIGURAZIONE TEMPO ---
#define SPEEDUP 1.6
#define TIMERSCALER 1
#define SECOND 0x17D7840 * TIMERSCALER

typedef char BOOL;
#define TRUE 1
#define FALSE 0

// --- STRUTTURA NOTA ---
typedef struct {
    uint32_t freq;      
    uint32_t duration;  
} NOTE;

// --- DURATE ---
typedef enum note_durations {
    time_semibiscroma = (unsigned int)(SECOND * SPEEDUP / 64.0f + 0.5),
    time_biscroma     = (unsigned int)(SECOND * SPEEDUP / 32.0f + 0.5),
    time_semicroma    = (unsigned int)(SECOND * SPEEDUP / 16.0f + 0.5),
    time_croma        = (unsigned int)(SECOND * SPEEDUP / 8.0f + 0.5),
    time_semiminima   = (unsigned int)(SECOND * SPEEDUP / 4.0f + 0.5),
    time_minima       = (unsigned int)(SECOND * SPEEDUP / 2.0f + 0.5),
    time_semibreve    = (unsigned int)(SECOND * SPEEDUP + 0.5),
    time_pause        = 0
} NOTE_DURATION;

// --- FREQUENZE (Abbassa Tonalità) ---
// Ho raddoppiato di nuovo i valori precedenti.
// Valori più alti = Timer più lento = Suono più grave.
enum frequencies {
    pause = 0,
    g4 = 5668, g4s = 5348, a4 = 5052, b4 = 4500,
    c5 = 4248, d5 = 3780,  e5 = 3368, f5 = 3184, g5 = 2836, a5 = 2528
};

// --- FUNZIONI ---
void music_init(void);
void music_start(void);
void music_stop(void);
void music_pause_resume(int pause_flag);
void music_player_tick(void); 

// Variabile globale per il volume
extern volatile int currentVolume;

#endif