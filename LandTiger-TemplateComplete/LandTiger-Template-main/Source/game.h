#ifndef GAME_H // evito di definirlo piu volte
#define GAME_H

#include <stdint.h>
#include "GLCD/GLCD.h"

/*----------------------------------------------------------------------------
 * Costanti di gioco
 *---------------------------------------------------------------------------*/
#define MAX_X           240
#define MAX_Y           320

#define Field_ROWS      20
#define Field_COLS      10
#define BLOCK_SIZE      15

/* Offset della griglia sul display */
#define BOARD_X_OFFSET  5
#define BOARD_Y_OFFSET  10

/*----------------------------------------------------------------------------
 * Stati del gioco
 *---------------------------------------------------------------------------*/
typedef enum {
    GAME_OVER,
    GAME_RUNNING,
    GAME_PAUSED
} GameStatus;

/* Tipi di tetramini */
typedef enum {
    I_BLOCK,
    J_BLOCK,
    L_BLOCK,
    O_BLOCK,
    S_BLOCK,
    T_BLOCK,
    Z_BLOCK
} BlockType;

/*----------------------------------------------------------------------------
 * Colori (RGB565)
 *---------------------------------------------------------------------------*/
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

/*----------------------------------------------------------------------------
 * Strutture dati
 *---------------------------------------------------------------------------*/
typedef struct {
    int row;
    int col;
} Point;

typedef struct {
    Point cells[4];     // celle che compongono il blocco
    Point position;     // posizione nella griglia
    uint16_t color;
    BlockType type;
    int rotation;
} Block;

/*----------------------------------------------------------------------------
 * Variabili globali
 *---------------------------------------------------------------------------*/
extern uint16_t board[Field_ROWS][Field_COLS];
extern Block currentBlock;
extern Block nextBlock;

extern volatile GameStatus status;
extern volatile int hard_drop_mode;

extern int score;

/*----------------------------------------------------------------------------
 * API di gioco
 *---------------------------------------------------------------------------*/
void game_init(void);
void game_update(void);
void spawn_block(void);
void draw_board_static(void);
void on_key1_pressed(void);

#endif
