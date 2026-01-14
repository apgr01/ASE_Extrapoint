#include "music.h"
#include "../timer/timer.h"
#include "LPC17xx.h"

/* --- LOGICA DI RIPRODUZIONE --- */
static int current_note_index = 0;
static volatile int is_playing = 0;

/* MELODIA ONE PIECE (We Are!) - Ritornello semplificato 
   Nota: Assicurati che le note (g4, a4, ecc.) siano in music.h
*/

/*
// --- TEMA TETRIS (Korobeiniki) --- 
NOTE song_tetris[] = {
    // --- Battuta 1 ---
    {e5, time_semiminima}, // E5 Lungo
    {b4, time_croma},      // B4 Corto
    {c5, time_croma},      // C5 Corto
    {d5, time_semiminima}, // D5 Lungo
    {c5, time_croma},      // C5 Corto
    {b4, time_croma},      // B4 Corto
    
    // --- Battuta 2 ---
    {a4, time_semiminima}, // A4 Lungo
    {a4, time_croma},      // A4 Corto
    {c5, time_croma},      // C5 Corto
    {e5, time_semiminima}, // E5 Lungo
    {d5, time_croma},      // D5 Corto
    {c5, time_croma},      // C5 Corto
    
    // --- Battuta 3 ---
    {b4, time_semiminima}, // B4 Lungo
    {b4, time_croma},      // B4 Corto
    {c5, time_croma},      // C5 Corto
    {d5, time_semiminima}, // D5 Lungo
    {e5, time_semiminima}, // E5 Lungo
    
    // --- Battuta 4 ---
    {c5, time_semiminima}, // C5 Lungo
    {a4, time_semiminima}, // A4 Lungo
    {a4, time_semiminima}, // A4 Lungo (Pausa implicita nel ritmo)
    
    // --- Pausa breve prima del loop ---
    {pause, time_semiminima}
};

#define SONG_LENGTH (sizeof(song_tetris) / sizeof(NOTE))
*/

NOTE song_one_piece[] = {
    // "Arittake no"
    {g4, time_croma}, {g4, time_croma}, {g4, time_croma}, {g4, time_croma},
    // "yume o"
    {a4, time_croma}, {c5, time_semiminima},
    // "kakiatsume"
    {c5, time_croma}, {c5, time_croma}, {d5, time_croma}, {c5, time_croma}, {b4, time_croma}, {a4, time_croma}, {g4, time_semiminima},
    {pause, time_croma}, 
    
    // "sagashi mono"
    {g4, time_croma}, {g4, time_croma}, {g4, time_croma}, {g4, time_croma},
    // "sagashini"
    {a4, time_croma}, {c5, time_semiminima},
    // "yuku no sa"
    {c5, time_croma}, {d5, time_croma}, {c5, time_croma}, {b4, time_croma}, {c5, time_croma}, {d5, time_semiminima},
    {pause, time_croma},

    // "ONE PIECE!"
    {e5, time_semiminima}, {d5, time_semiminima}, {c5, time_minima},
    {pause, time_semiminima}
};

#define SONG_LENGTH (sizeof(song_one_piece) / sizeof(NOTE))

void playNote(NOTE note) {
    // --- TIMER 2: FREQUENZA (SUONO) ---
    if (note.freq != pause) {
        reset_timer(2);
        // init_timer(TimerNum, Prescale, MatchReg, MatchOpt, MatchVal)
        // MatchOpt = 3 significa: Interrupt (1) + Reset on Match (2)
        init_timer(2, 0, 0, 3, note.freq);
        enable_timer(2);
    } else {
        // Se è una pausa, spegniamo il timer del suono
        disable_timer(2);
        reset_timer(2);
    }
    
    // --- TIMER 1: DURATA (METRONOMO) ---
    reset_timer(1);
    // Impostiamo la durata della nota
    init_timer(1, 0, 0, 3, note.duration); 
    enable_timer(1);
}

BOOL isNotePlaying(void) {
    return is_playing;
}

void music_init(void) {
    current_note_index = 0;
    is_playing = 0;
    // Assicuriamoci che il PIN dello speaker (P0.26) sia Output
    LPC_PINCON->PINSEL1 &= ~(3 << 20); // GPIO
    LPC_GPIO0->FIODIR |= (1 << 26);    // Output
}

void music_start(void) {
    // Abilitiamo gli interrupt dei Timer nel NVIC (se non fatto in init_timer)
    NVIC_EnableIRQ(TIMER1_IRQn);
    NVIC_EnableIRQ(TIMER2_IRQn);
    
    current_note_index = 0;
    is_playing = 1;
    playNote(song_one_piece[0]);
}

void music_stop(void) {
    is_playing = 0;
    disable_timer(1);
    disable_timer(2);
    reset_timer(1);
    reset_timer(2);
}

void music_pause_resume(int pause_flag) {
    if (pause_flag) {
        disable_timer(1);
        disable_timer(2);
    } else {
        if (is_playing) {
            enable_timer(1);
            // Riabilita il suono solo se NON eravamo in una pausa musicale
            if (song_one_piece[current_note_index].freq != pause) {
                enable_timer(2);
            }
        }
    }
}

void music_player_tick(void) {
    if (!is_playing) return;

    current_note_index++;
    
    if (current_note_index >= SONG_LENGTH) {
        current_note_index = 0; // Loop infinito
    }
    
    playNote(song_one_piece[current_note_index]);
}