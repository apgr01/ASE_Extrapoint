#ifndef MUSIC_H
#define MUSIC_H

#include "LPC17xx.h"

// --- DEFINIZIONI BASE ---
#define SPEEDUP 1.6
#define TIMERSCALER 1
#define SECOND 0x17D7840 * TIMERSCALER

typedef char BOOL;
#define TRUE 1
#define FALSE 0

// --- STRUTTURA NOTA ---
typedef struct {
    uint32_t freq;      // Valore del registro match per la frequenza
    uint32_t duration;  // Durata in tick del timer
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
    time_pause        = 0 // Frequenza per la pausa
} NOTE_DURATION;

// --- FREQUENZE (Valori K per Timer) ---
// Se mancano nel tuo file originale, aggiungi queste per la scala centrale
enum frequencies {
    pause = 0,
    c4 = 2120, d4 = 1890, e4 = 1684, f4 = 1592, g4 = 1417, a4 = 1263, b4 = 1125,
    c5 = 1062, d5 = 945,  e5 = 842,  f5 = 796,  g5 = 709,  a5 = 632,  b5 = 563
};

// --- FUNZIONI ESPORTATE ---
void music_init(void);
void music_start(void);
void music_stop(void);
void music_pause_resume(int pause_flag);
void music_player_tick(void); // Da chiamare nell'IRQ del Timer1

#endif