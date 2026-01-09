#ifndef GAME_H
#define GAME_H

#include <stdint.h>
#include "GLCD/GLCD.h" /* Assicurati che il percorso sia corretto */

// --- Dimensioni e Costanti di Gioco ---
#define MAX_X           240     // Larghezza schermo LandTiger
#define MAX_Y           320     // Altezza schermo LandTiger

#define Field_ROWS      20      // Righe della griglia di gioco
#define Field_COLS      10      // Colonne della griglia di gioco
#define BLOCK_SIZE      15      // Dimensione in pixel di ogni blocco (quadrato)

// Calcolo offset per centrare la griglia o metterla a sinistra
// Esempio: Margine sinistro di 5 pixel, Margine alto di 10 pixel
#define BOARD_X_OFFSET  5
#define BOARD_Y_OFFSET  10

// Stati del Gioco
typedef enum {
    GAME_OVER,
    GAME_RUNNING,
    GAME_PAUSED
} GameStatus;

// Tipi di Tetramini (I, J, L, O, S, T, Z)
typedef enum {
    I_BLOCK, J_BLOCK, L_BLOCK, O_BLOCK, S_BLOCK, T_BLOCK, Z_BLOCK
} BlockType;

// --- Colori Tetris (Formato RGB565) ---
// Formato: 5 bit Rosso, 6 bit Verde, 5 bit Blu
// I nomi iniziano con T_ per distinguerli da quelli di sistema

#define T_Cyan      0x07FF  // Ciano (I piece) - R=0, G=63, B=31 (Nota: 0x7FFF è ciano chiaro, 0x07FF è puro ciano standard)
#define T_Blue      0x001F  // Blu (J piece) - R=0, G=0, B=31
#define T_Orange    0xFD20  // Arancione (L piece) - R=31, G=40, B=0
#define T_Yellow    0xFFE0  // Giallo (O piece) - R=31, G=63, B=0
#define T_Green     0x07E0  // Verde (S piece) - R=0, G=63, B=0
#define T_Magenta   0xF81F  // Magenta (T piece) - R=31, G=0, B=31
#define T_Red       0xF800  // Rosso (Z piece) - R=31, G=0, B=0

// Colori di utilità
#define T_Black     0x0000  // Sfondo
#define T_White     0xFFFF  // Testo/Bordi
#define T_Grey      0x8410  // Grigio per griglia/ombra (opzionale)


// --- Strutture Dati ---

// Un punto nella griglia (coordinate riga, colonna)
typedef struct {
    int row;
    int col;
} Point;

// Definizione di un blocco (Tetramino)
typedef struct {
    Point cells[4];     // Ogni blocco è formato da 4 celle
    Point position;     // Posizione (riga, colonna) del centro/pivot del blocco nella griglia
    uint16_t color;     // Colore del blocco (usiamo i colori definiti in GLCD.h)
    BlockType type;     // Tipo di blocco
    int rotation;       // Stato di rotazione (0, 1, 2, 3)
} Block;

// Variabili Globali Esterne (accessibili da main e interrupt)
extern uint16_t board[Field_ROWS][Field_COLS]; // Matrice che rappresenta la griglia (contiene i colori)
extern Block currentBlock;                     // Il blocco che sta cadendo
extern Block nextBlock;                        // Il prossimo blocco (per la preview)
extern volatile GameStatus status;             // Stato corrente del gioco
extern int score;                              // Punteggio corrente

// --- Prototipi di Funzione ---
void game_init(void);          // Inizializza variabili e schermo
void game_update(void);        // Logica principale (chiamata dal timer)
void spawn_block(void);        // Genera un nuovo blocco
void draw_board_static(void);  // Disegna i contorni statici
extern volatile int hard_drop_mode;
extern void on_key1_pressed(void);
#endif