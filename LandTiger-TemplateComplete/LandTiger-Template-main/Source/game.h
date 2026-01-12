#ifndef GAME_H
#define GAME_H

#include <stdint.h>
#include "GLCD/GLCD.h"

/* --- COSTANTI DI GIOCO & DEBUG --- */
// Modifica questi valori per testare rapidamente
#define LINES_FOR_POWERUP   2   // Ogni quante righe genero un powerup (Debug: 1)
#define LINES_FOR_MALUS     10   // Ogni quante righe genero un malus (Debug: 2)

#define MAX_X           240
#define MAX_Y           320

#define Field_ROWS      20
#define Field_COLS      10
#define BLOCK_SIZE      15

#define BOARD_X_OFFSET  5
#define BOARD_Y_OFFSET  10

/* --- TIPI DATI --- */

typedef enum {
    GAME_OVER,
    GAME_RUNNING,
    GAME_PAUSED
} GameStatus;

// Nuovo Enum per i PowerUp
typedef enum {
    POWER_NONE = 0,
    POWER_CLEAR,    // Identificato dalla lettera 'C'
    POWER_SLOW      // Identificato dalla lettera 'S'
} PowerUpType;

typedef enum {
    I_BLOCK, J_BLOCK, L_BLOCK, O_BLOCK, S_BLOCK, T_BLOCK, Z_BLOCK
} BlockType;

/* Colori (Invariati) */
#define T_Cyan      0x07FF
#define T_Blue      0x001F
#define T_Orange    0xFD20
#define T_Yellow    0xFFE0
#define T_Green     0x07E0
#define T_Magenta   0xF81F
#define T_Red       0xF800
#define T_Black     0x0000
#define T_White     0xFFFF
#define T_Grey      0x8410

/* Strutture */
typedef struct {
    int row;
    int col;
} Point;

typedef struct {
    Point cells[4];
    Point position;
    uint16_t color;
    BlockType type;
    int rotation;
} Block;

/* --- VARIABILI GLOBALI ESPORTATE --- */
extern uint16_t board[Field_ROWS][Field_COLS];
// Nuova matrice parallela per tracciare dove sono i powerup
extern uint8_t board_powers[Field_ROWS][Field_COLS]; 

extern Block currentBlock;
extern Block nextBlock;
extern volatile GameStatus status;
extern volatile int hard_drop_mode;
extern int score;

// Contatori per la logica extrapoints
extern int total_lines_cleared; 

/* API */
void game_init(void);
void game_update(void);
// Aggiungeremo queste funzioni dopo, per ora le dichiaro
void apply_powerup(PowerUpType type, int row);
void spawn_random_powerup(void);
void apply_malus(void);

#endif