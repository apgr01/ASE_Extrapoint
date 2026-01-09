#include "game.h"
#include "LPC17xx.h" 
#include <stdlib.h>
#include <stdio.h> 

// --- Variabili Globali ---
uint16_t board[Field_ROWS][Field_COLS];
Block currentBlock;
Block nextBlock;

// Inizializziamo a PAUSED così il gioco non parte da solo
volatile GameStatus status = GAME_PAUSED;

int score = 0;
int lines_cleared_total = 0; 
volatile int highScore = 0; 

volatile int hard_drop_mode = 0; 

// --- Variabili Esterne dal RIT (Joystick) ---
extern volatile int J_left;
extern volatile int J_right;
extern volatile int J_up;    
extern volatile int J_down;  

// Forme dei blocchi 
const Point TETROMINO_SHAPES[7][4] = {
    {{0, -1}, {0, 0}, {0, 1}, {0, 2}},  // I
    {{0, -1}, {0, 0}, {0, 1}, {1, 1}},  // J
    {{0, -1}, {0, 0}, {0, 1}, {1, -1}}, // L
    {{0, 0}, {0, 1}, {1, 0}, {1, 1}},   // O
    {{0, -1}, {0, 0}, {1, 0}, {1, 1}},  // S
    {{0, -1}, {0, 0}, {0, 1}, {1, 0}},  // T
    {{0, 1}, {0, 0}, {1, 0}, {1, -1}}   // Z
};

const uint16_t TETROMINO_COLORS[7] = {
    T_Cyan, T_Blue, T_Orange, T_Yellow, T_Green, T_Magenta, T_Red
};

// --- Funzioni di Disegno (Low Level) ---

void draw_grid_cell(int row, int col, uint16_t color) {
    int x0 = BOARD_X_OFFSET + (col * BLOCK_SIZE);
    int y0 = BOARD_Y_OFFSET + (row * BLOCK_SIZE);
    int i, j;
    
    for (i = 0; i < BLOCK_SIZE; i++) {
        for (j = 0; j < BLOCK_SIZE; j++) {
            if (i == BLOCK_SIZE - 1 || j == BLOCK_SIZE - 1)
                LCD_SetPoint(x0 + j, y0 + i, T_Black); 
            else
                LCD_SetPoint(x0 + j, y0 + i, color);   
        }
    }
}

void draw_tetromino(Block block, uint16_t color) {
    int i;
    for(i = 0; i < 4; i++) {
        int r = block.position.row + block.cells[i].row;
        int c = block.position.col + block.cells[i].col;
        
        if(r >= 0 && r < Field_ROWS && c >= 0 && c < Field_COLS) {
            draw_grid_cell(r, c, color);
        }
    }
}

void draw_board_static(void) {
    int i;
    char str[15];
    int x_start = BOARD_X_OFFSET - 1;
    int y_start = BOARD_Y_OFFSET - 1;
    int width_px = Field_COLS * BLOCK_SIZE + 2;
    int height_px = Field_ROWS * BLOCK_SIZE + 2;

    // Cornice
    for(i = 0; i < width_px; i++) {
        LCD_SetPoint(x_start + i, y_start, White);
        LCD_SetPoint(x_start + i, y_start + height_px, White);
    }
    for(i = 0; i < height_px; i++) {
        LCD_SetPoint(x_start, y_start + i, White);
        LCD_SetPoint(x_start + width_px, y_start + i, White);
    }

    // --- INTERFACCIA LATERALE ---
    
    // Score
    GUI_Text(160, 20, (uint8_t *) "SCORE", White, Black);
    sprintf(str, "%d", score);
    GUI_Text(160, 40, (uint8_t *)str, White, Black);

    // Lines 
    GUI_Text(160, 70, (uint8_t *) "LINES", White, Black);
    sprintf(str, "%d", lines_cleared_total);
    GUI_Text(160, 90, (uint8_t *)str, White, Black);

    // High Score
    GUI_Text(160, 120, (uint8_t *) "HI-SCORE", White, Black);
    sprintf(str, "%d", highScore);
    GUI_Text(160, 140, (uint8_t *)str, Yellow, Black);
    
    // Next
    GUI_Text(160, 170, (uint8_t *) "NEXT", White, Black);
    
    // Status Text (Se siamo in pausa all'inizio) -> SPOSTATO A 265
    if (status == GAME_PAUSED) {
        GUI_Text(160, 265, (uint8_t *) "PAUSED", Yellow, Black);
    }
}

// --- Funzione Anteprima ---
void draw_block_in_preview(Block blk, uint16_t color) {
    int start_x = 160;
    int start_y = 190; // Il blocco viene disegnato da qui in giù (finisce circa a 250)
    int i, a, b;

    for(i = 0; i < 4; i++) {
        int r = blk.cells[i].row + 1; 
        int c = blk.cells[i].col + 1;
        int px = start_x + (c * BLOCK_SIZE);
        int py = start_y + (r * BLOCK_SIZE);
        
        for (a = 0; a < BLOCK_SIZE; a++) {
            for (b = 0; b < BLOCK_SIZE; b++) {
                if (a == BLOCK_SIZE - 1 || b == BLOCK_SIZE - 1)
                    LCD_SetPoint(px + b, py + a, T_Black); 
                else
                    LCD_SetPoint(px + b, py + a, color);   
            }
        }
    }
}

// --- Logica di Gioco ---

int check_collision(Block b) {
    int i;
    for(i = 0; i < 4; i++) {
        int r = b.position.row + b.cells[i].row;
        int c = b.position.col + b.cells[i].col;
        
        if (r >= Field_ROWS) return 1; 
        if (c < 0 || c >= Field_COLS) return 1;
        if (r >= 0 && board[r][c] != T_Black) return 1;
    }
    return 0;
}

void check_lines(void) {
    int row, col, k;
    int lines_cleared = 0;
    char str[15];
    
    for(row = Field_ROWS - 1; row >= 0; row--) {
        int full = 1;
        for(col = 0; col < Field_COLS; col++) {
            if(board[row][col] == T_Black) {
                full = 0; break;
            }
        }
        
        if(full) {
            lines_cleared++;
            for(k = row; k > 0; k--) {
                for(col = 0; col < Field_COLS; col++) {
                    board[k][col] = board[k-1][col];
                }
            }
            for(col = 0; col < Field_COLS; col++) {
                board[0][col] = T_Black;
            }
            row++; 
        }
    }
    
    if(lines_cleared > 0) {
        // Aggiorna Linee Totali
        lines_cleared_total += lines_cleared;
        sprintf(str, "%d", lines_cleared_total);
        GUI_Text(160, 90, (uint8_t *)str, White, Black);

        // Aggiorna Punti (Specifica 9)
        if (lines_cleared == 4) {
            score += 600; 
        } else {
            score += (lines_cleared * 100); 
        }
        
        sprintf(str, "%d", score);
        GUI_Text(160, 40, (uint8_t *)str, White, Black);
        
        // Ridisegna griglia
        for(row=0; row<Field_ROWS; row++) {
             for(col=0; col<Field_COLS; col++) {
                 draw_grid_cell(row, col, board[row][col]);
             }
        }
    }
}

void spawn_block(void) {
    int i;
    // Primo avvio
    if (currentBlock.type == 0 && nextBlock.type == 0) {
        nextBlock.type = (BlockType)(rand() % 7);
        nextBlock.color = TETROMINO_COLORS[nextBlock.type];
        nextBlock.rotation = 0;
        for(i=0; i<4; i++) nextBlock.cells[i] = TETROMINO_SHAPES[nextBlock.type][i];
    }

    currentBlock = nextBlock;
    currentBlock.position.row = 1; 
    currentBlock.position.col = Field_COLS / 2;

    draw_block_in_preview(currentBlock, T_Black); // Cancella

    nextBlock.type = (BlockType)(rand() % 7);
    nextBlock.color = TETROMINO_COLORS[nextBlock.type];
    nextBlock.rotation = 0;
    for(i=0; i<4; i++) nextBlock.cells[i] = TETROMINO_SHAPES[nextBlock.type][i];
    
    draw_block_in_preview(nextBlock, nextBlock.color); // Disegna
}

// Questa funzione viene chiamata da KEY 1 (IRQ_RIT)
void on_key1_pressed(void) {
    // --- GENERAZIONE CASUALE (SEED) ---
    // Usiamo il valore attuale del Timer0 (TC) come seme.
    // Poiché il timer corre a 25MHz (o simile), è impossibile premere
    // il tasto nello stesso identico microsecondo due volte.
    // Questo garantisce partite sempre diverse.
    srand(LPC_TIM0->TC);

    // 1. Se GAME OVER -> Ricomincia partita
    if (status == GAME_OVER) {
        game_init();
        return;
    }
    
    // 2. Se PAUSA -> Riprendi
    if (status == GAME_PAUSED) {
        status = GAME_RUNNING;
        
        // Cancella la scritta "PAUSED" scrivendoci sopra spazi neri
        GUI_Text(160, 265, (uint8_t *) "      ", Black, Black); 
        
        // (Opzionale) Se è proprio l'inizio della partita (score 0), 
        // potremmo rigenerare il nextBlock qui per rendere casuale anche il secondo pezzo,
        // ma generalmente basta che siano casuali tutti quelli successivi.
    } 
    // 3. Se RUNNING -> Metti in Pausa
    else if (status == GAME_RUNNING) {
        status = GAME_PAUSED;
        GUI_Text(160, 265, (uint8_t *) "PAUSED", Yellow, Black);
    }
}
void game_init(void) {
    int i, j;
    
    // PRIORITA' INTERRUPT
    NVIC_SetPriority(RIT_IRQn, 1);    
    NVIC_SetPriority(TIMER0_IRQn, 2); 
    
    for(i = 0; i < Field_ROWS; i++) {
        for(j = 0; j < Field_COLS; j++) {
            board[i][j] = T_Black;
        }
    }
    
    score = 0; 
    lines_cleared_total = 0;
    
    // Importante: Inizia in PAUSA come richiesto
    status = GAME_PAUSED;
    
    // Resetta i blocchi per forzare una nuova generazione pulita
    currentBlock.type = 0;
    nextBlock.type = 0;
    
    LCD_Clear(T_Black);
    draw_board_static(); 
    spawn_block();
}

void lock_block(void) {
    int i;
    char str[15];
    
    for(i = 0; i < 4; i++) {
        int r = currentBlock.position.row + currentBlock.cells[i].row;
        int c = currentBlock.position.col + currentBlock.cells[i].col;
        if(r >= 0 && r < Field_ROWS && c >= 0 && c < Field_COLS) {
            board[r][c] = currentBlock.color;
        }
    }
    
    // Punti per piazzamento
    score += 10;
    sprintf(str, "%d", score);
    GUI_Text(160, 40, (uint8_t *)str, White, Black);

    hard_drop_mode = 0; 
    check_lines(); 
    
    spawn_block();
    draw_tetromino(currentBlock, currentBlock.color);
    
    if (check_collision(currentBlock)) {
        status = GAME_OVER;
        GUI_Text(50, 150, (uint8_t *)"GAME OVER", Red, White);
        
        if (score > highScore) {
            highScore = score;
            sprintf(str, "%d", highScore);
            GUI_Text(160, 140, (uint8_t *)str, Yellow, Black);
            GUI_Text(50, 170, (uint8_t *)"NEW RECORD!", Yellow, Black);
        }
        
        // Messaggio per ricominciare
        GUI_Text(30, 190, (uint8_t *)"PRESS KEY1", White, Black);
    }
}

void rotate_block(void) {
    Block temp = currentBlock;
    int i;
    if (temp.type == O_BLOCK) return;
    for(i = 0; i < 4; i++) {
        int oldRow = temp.cells[i].row;
        int oldCol = temp.cells[i].col;
        temp.cells[i].row = oldCol;
        temp.cells[i].col = -oldRow;
    }
    temp.rotation = (temp.rotation + 1) % 4;
    if (check_collision(temp) == 0) {
        draw_tetromino(currentBlock, T_Black);
        currentBlock = temp;
        draw_tetromino(currentBlock, currentBlock.color);
    }
}

static int ticks = 0;

void game_update(void) {
    Block temp;
    
    // Se non è RUNNING, non fare nulla (Pausa o Game Over)
    if (status != GAME_RUNNING) return;

    if (hard_drop_mode == 1) {
        draw_tetromino(currentBlock, T_Black);
        while (check_collision(currentBlock) == 0) {
            currentBlock.position.row++;
        }
        currentBlock.position.row--; 
        draw_tetromino(currentBlock, currentBlock.color);
        lock_block();
        return; 
    }

    if (J_up != 0) {
        rotate_block();
        J_up = 0; 
    }
    if (J_left != 0) {
        temp = currentBlock;
        temp.position.col--; 
        if (check_collision(temp) == 0) {
            draw_tetromino(currentBlock, T_Black);
            currentBlock = temp;
            draw_tetromino(currentBlock, currentBlock.color);
        }
        J_left = 0; 
    }
    if (J_right != 0) {
        temp = currentBlock;
        temp.position.col++; 
        if (check_collision(temp) == 0) {
            draw_tetromino(currentBlock, T_Black);
            currentBlock = temp;
            draw_tetromino(currentBlock, currentBlock.color);
        }
        J_right = 0; 
    }

    ticks++;
    int threshold = 40; 
    if (J_down != 0) threshold = 2; 
    
    if (ticks >= threshold) { 
        ticks = 0; 
        temp = currentBlock;
        temp.position.row++;
        if (check_collision(temp)) {
            lock_block();
        } else {
            draw_tetromino(currentBlock, T_Black); 
            currentBlock.position.row++;           
            draw_tetromino(currentBlock, currentBlock.color); 
        }
    } 
}