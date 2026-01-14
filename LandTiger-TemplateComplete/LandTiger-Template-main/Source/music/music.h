#ifndef MUSIC_H
#define MUSIC_H

#include "LPC17xx.h"

// --- CONFIGURAZIONE ---
#define SPEEDUP 1.8  
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
    time_semiminima_p = (unsigned int)(SECOND * SPEEDUP / 4.0f * 1.5f + 0.5), 
    time_minima       = (unsigned int)(SECOND * SPEEDUP / 2.0f + 0.5),       
    time_semibreve    = (unsigned int)(SECOND * SPEEDUP + 0.5),              
    time_pause        = 0
} NOTE_DURATION;

// --- FREQUENZE (Basse per musica, Alte per effetti) ---
enum frequencies {
    pause = 0,
    // Ottava 3 (Bassi - Musica)
    e3 = 151686, a3 = 113636, b3 = 101238,
    // Ottava 4 (Medi - Musica)
    c4 = 95556, d4 = 85130, e4 = 75842, f4 = 71586, g4 = 63774, g4s = 60196, a4 = 56818, b4 = 50618,
    // Ottava 5 (Alti - Musica)
    c5 = 47778, d5 = 42564, e5 = 37920, f5 = 35792, g5 = 31886, a5 = 28408,
    
    // --- OTTAVA 6 (NUOVA - Solo per Effetti Sonori) ---
    c6 = 23889, e6 = 18960, g6 = 15943, c7 = 11944
};

// --- FUNZIONI ---
void music_init(void);
void music_start(void);
void music_stop(void);
void music_pause_resume(int pause_flag);
void music_player_tick(void); 

// NUOVA FUNZIONE
void music_play_clear_sfx(void);

extern volatile int currentVolume;

#endif