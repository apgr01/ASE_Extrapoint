#include "game.h"
#include "LPC17xx.h"
#include <stdlib.h>
#include <stdio.h>
#include "../adc/adc.h"

/* --- COSTANTI INTERFACCIA --- */
#define UI_COL_X             160
#define Y_SCORE              40
#define Y_LINES              90
#define Y_HISCORE            140
#define Y_STATUS             265
#define DROP_DELAY_NORMAL    40

/* --- VARIABILI GLOBALI --- */
uint16_t board[Field_ROWS][Field_COLS];
uint8_t board_powers[Field_ROWS][Field_COLS];

Block currentBlock, nextBlock;
volatile GameStatus status = GAME_PAUSED;

int score = 0;
int lines_cleared_total = 0;
volatile int highScore = 0;
volatile int slow_powerup_timer = 0;

// Potenziometro
extern unsigned short AD_current;

/* Controllo flusso */
volatile int hard_drop_mode = 0;
volatile int restart_requested = 0;
static int drop_ticks = 0;

/* Input esterni dal RIT */
extern volatile int J_left, J_right, J_up, J_down;

/* --- DEFINIZIONE TETROMINI --- */
const Point TETROMINO_SHAPES[7][4] = {
    {{0, -1}, {0, 0}, {0, 1}, {0, 2}},  /* I */
    {{0, -1}, {0, 0}, {0, 1}, {1, 1}},  /* J */
    {{0, -1}, {0, 0}, {0, 1}, {1, -1}}, /* L */
    {{0, 0}, {0, 1}, {1, 0}, {1, 1}},   /* O */
    {{0, -1}, {0, 0}, {1, 0}, {1, 1}},  /* S */
    {{0, -1}, {0, 0}, {0, 1}, {1, 0}},  /* T */
    {{0, 1}, {0, 0}, {1, 0}, {1, -1}}   /* Z */
};

const uint16_t TETROMINO_COLORS[7] = {
    T_Cyan, T_Blue, T_Orange, T_Yellow, T_Green, T_Magenta, T_Red
};

/* --- FUNZIONI DI SUPPORTO (GUI) --- */

static void update_label(int y, int value, uint16_t color) {
    char buf[12];
    sprintf(buf, "%d", value);
    GUI_Text(UI_COL_X, y, (uint8_t *)buf, color, Black);
}

void draw_grid_cell(int row, int col, uint16_t color) {
    int i, j;
    int x0 = BOARD_X_OFFSET + (col * BLOCK_SIZE);
    int y0 = BOARD_Y_OFFSET + (row * BLOCK_SIZE);
    
    // 1. Disegna il quadrato colorato
    for (i = 0; i < BLOCK_SIZE; i++) {
        for (j = 0; j < BLOCK_SIZE; j++) {
            uint16_t p_color = (i == BLOCK_SIZE - 1 || j == BLOCK_SIZE - 1) ? T_Black : color;
            LCD_SetPoint(x0 + j, y0 + i, p_color);
        }
    }

    // 2. Overlay Lettera PowerUp
    if (color != T_Black && board_powers[row][col] != POWER_NONE) {
        char letter[2] = " ";
        if (board_powers[row][col] == POWER_CLEAR) letter[0] = 'C';
        else if (board_powers[row][col] == POWER_SLOW) letter[0] = 'S';
        
        GUI_Text(x0 + 4, y0, (uint8_t *)letter, T_Black, color);
    }
}

void draw_tetromino(Block block, uint16_t color) {
    int i, r, c;
    for (i = 0; i < 4; i++) {
        r = block.position.row + block.cells[i].row;
        c = block.position.col + block.cells[i].col;
        if (r >= 0 && r < Field_ROWS && c >= 0 && c < Field_COLS) {
            draw_grid_cell(r, c, color);
        }
    }
}

void draw_board(void) {
    int i;
    int w = Field_COLS * BLOCK_SIZE + 2;
    int h = Field_ROWS * BLOCK_SIZE + 2;
    int x = BOARD_X_OFFSET - 1;
    int y = BOARD_Y_OFFSET - 1;

    for (i = 0; i < w; i++) {
        LCD_SetPoint(x + i, y, White);
        LCD_SetPoint(x + i, y + h, White);
    }
    for (i = 0; i < h; i++) {
        LCD_SetPoint(x, y + i, White);
        LCD_SetPoint(x + w, y + i, White);
    }

    GUI_Text(UI_COL_X, 20,  (uint8_t *)"SCORE",    White, Black);
    GUI_Text(UI_COL_X, 70,  (uint8_t *)"LINES",    White, Black);
    GUI_Text(UI_COL_X, 120, (uint8_t *)"HI-SCORE", White, Black);
    GUI_Text(UI_COL_X, 170, (uint8_t *)"NEXT",     White, Black);

    update_label(Y_SCORE, score, White);
    update_label(Y_LINES, lines_cleared_total, White);
    update_label(Y_HISCORE, highScore, Yellow);

    if (status == GAME_PAUSED) {
        GUI_Text(UI_COL_X, Y_STATUS, (uint8_t *)"PAUSED", Yellow, Black);
    }
}

void draw_block_preview(Block blok, uint16_t color) {
    int i, a, b, px, py;
    int start_x = 160, start_y = 190;

    for (i = 0; i < 4; i++) {
        px = start_x + ((blok.cells[i].col + 1) * BLOCK_SIZE);
        py = start_y + ((blok.cells[i].row + 1) * BLOCK_SIZE);
        for (a = 0; a < BLOCK_SIZE; a++) {
            for (b = 0; b < BLOCK_SIZE; b++) {
                uint16_t p_color = (a == BLOCK_SIZE - 1 || b == BLOCK_SIZE - 1) ? T_Black : color;
                LCD_SetPoint(px + b, py + a, p_color);
            }
        }
    }
}

void spawn_random_powerup(void) {
    int r, c;
    int occupied_count = 0;
    static Point occupied_blocks[Field_ROWS * Field_COLS]; 

    // 1. Cerca blocchi candidati (Pieni e senza potere)
    for (r = 0; r < Field_ROWS; r++) {
        for (c = 0; c < Field_COLS; c++) {
            if (board[r][c] != T_Black && board_powers[r][c] == POWER_NONE) {
                occupied_blocks[occupied_count].row = r;
                occupied_blocks[occupied_count].col = c;
                occupied_count++;
            }
        }
    }

    if (occupied_count == 0) return; // Nessun blocco disponibile

    // 2. Scegli a caso
    int rand_idx = rand() % occupied_count;
    Point target = occupied_blocks[rand_idx];

    // 3. Assegna potere (50% Clear, 50% Slow)
    PowerUpType new_power = (rand() % 2 == 0) ? POWER_CLEAR : POWER_SLOW;
    board_powers[target.row][target.col] = new_power;

    // 4. Ridisegna SOLO quella cella per mostrare la lettera
    draw_grid_cell(target.row, target.col, board[target.row][target.col]);
}

void apply_malus(void) {
    int i, r, c;
    
    // 1. Controllo Game Over: Se la riga 0 non è vuota, abbiamo perso
    for (c = 0; c < Field_COLS; c++) {
        if (board[0][c] != T_Black) {
            status = GAME_OVER;
            GUI_Text(50, 150, (uint8_t *)" GAME OVER ", Red, White);
            return;
        }
    }

    // 2. Shift verso l'ALTO (da riga 1 a riga 0, ecc.)
    for (r = 0; r < Field_ROWS - 1; r++) {
        for (c = 0; c < Field_COLS; c++) {
            board[r][c] = board[r+1][c];
            board_powers[r][c] = board_powers[r+1][c]; // Sposta anche i poteri
        }
    }

    // 3. Generazione Riga Sporca (Fondo)
    // Creiamo un array temporaneo con 7 blocchi (1) e 3 buchi (0)
    int row_pattern[Field_COLS] = {1, 1, 1, 1, 1, 1, 1, 0, 0, 0};
    
    // Shuffle dell'array (Fisher-Yates semplificato) per mischiare buchi e pieni
    for (i = 0; i < Field_COLS; i++) {
        int swap_idx = rand() % Field_COLS;
        int temp = row_pattern[i];
        row_pattern[i] = row_pattern[swap_idx];
        row_pattern[swap_idx] = temp;
    }

    // Applica alla riga 19
    for (c = 0; c < Field_COLS; c++) {
        if (row_pattern[c] == 1) {
            board[Field_ROWS - 1][c] = T_Grey; // Colore per i blocchi malus (Grigio)
            board_powers[Field_ROWS - 1][c] = POWER_NONE;
        } else {
            board[Field_ROWS - 1][c] = T_Black;
            board_powers[Field_ROWS - 1][c] = POWER_NONE;
        }
    }

    // 4. Ridisegna tutto il campo
    for (r = 0; r < Field_ROWS; r++) {
        for (c = 0; c < Field_COLS; c++) draw_grid_cell(r, c, board[r][c]);
    }
}

void apply_clear_half(void) {
    int i, r, c, k;
    int highest_row = Field_ROWS; // Partiamo dal fondo+1 (vuoto)

    // 1. Calcola l'altezza effettiva della pila (Trova la prima riga occupata dall'alto)
    for (r = 0; r < Field_ROWS; r++) {
        for (c = 0; c < Field_COLS; c++) {
            if (board[r][c] != T_Black) {
                highest_row = r;
                goto found_height; // Esci dai due loop
            }
        }
    }
    found_height:;

    // Se il campo è vuoto, esci
    if (highest_row == Field_ROWS) return;

    int stack_height = Field_ROWS - highest_row;
    int lines_to_remove = stack_height / 2;

    // Se c'è meno di 2 righe (es. 1 riga), 1/2 = 0. Non facciamo nulla o togliamo l'ultima?
    // Specifica: "Clear half". Se 1 riga, ne togliamo 0.
    if (lines_to_remove == 0) return;

    // 2. Rimuovi le 'lines_to_remove' righe PIÙ IN BASSO (dal fondo a salire)
    // Eseguiamo lo shift verso il basso per ogni riga rimossa
    for (i = 0; i < lines_to_remove; i++) {
        // Copiamo tutto verso il basso a partire dalla penultima riga in su
        // (Simile a quando si cancella una riga nel tetris classico)
        for (k = Field_ROWS - 1; k > 0; k--) {
            for (c = 0; c < Field_COLS; c++) {
                board[k][c] = board[k-1][c];
                board_powers[k][c] = board_powers[k-1][c];
            }
        }
        // Pulisci riga 0
        for (c = 0; c < Field_COLS; c++) {
            board[0][c] = T_Black;
            board_powers[0][c] = POWER_NONE;
        }
    }

    // 3. Punteggio (come da specifica)
    // "award points in groups of 4"
    int temp_lines = lines_to_remove;
    while (temp_lines > 0) {
        if (temp_lines >= 4) {
            score += 600; 
            temp_lines -= 4;
        } else {
            score += (temp_lines * 100); 
            temp_lines = 0;
        }
    }
    update_label(Y_SCORE, score, White);

    // Nota: Ridisegneremo tutto alla fine di check_lines
}

/* --- LOGICA DI GIOCO --- */

int check_collision(Block b) {
    int i, r, c;
    for (i = 0; i < 4; i++) {
        r = b.position.row + b.cells[i].row;
        c = b.position.col + b.cells[i].col;
        if (r >= Field_ROWS || c < 0 || c >= Field_COLS) return 1;
        if (r >= 0 && board[r][c] != T_Black) return 1;
    }
    return 0;
}

void check_lines(void) {
    int r, c, k, full, lines_found = 0;
    
    // Flag memorizzati PRIMA di cancellare le righe
    int trigger_clear_half = 0;
    int trigger_slow = 0;
    
    // --- STEP 1: Analisi e Pulizia Standard (La riga corrente viene eliminata) ---
    for (r = Field_ROWS - 1; r >= 0; r--) {
        full = 1;
        for (c = 0; c < Field_COLS; c++) {
            if (board[r][c] == T_Black) { full = 0; break; }
        }
        
        if (full) {
            // Controlla se c'erano powerup su QUESTA riga specifica
            for (c = 0; c < Field_COLS; c++) {
                if (board_powers[r][c] == POWER_CLEAR) trigger_clear_half = 1;
                if (board_powers[r][c] == POWER_SLOW) trigger_slow = 1;
            }

            lines_found++;
            
            // Elimina la riga e fai scendere tutto (Tetris Standard)
            for (k = r; k > 0; k--) {
                for (c = 0; c < Field_COLS; c++) {
                    board[k][c] = board[k-1][c];
                    board_powers[k][c] = board_powers[k-1][c];
                }
            }
            // Pulisci riga 0
            for (c = 0; c < Field_COLS; c++) {
                board[0][c] = T_Black;
                board_powers[0][c] = POWER_NONE;
            }
            r++; // Ricontrolla la stessa riga (ora occupata da quella sopra)
        }
    }
    
    // Se non abbiamo fatto righe, usciamo subito
    if (lines_found == 0) return;

    // --- Aggiornamento Punteggi Base ---
    lines_cleared_total += lines_found;
    score += (lines_found == 4) ? 600 : (lines_found * 100);
    update_label(Y_LINES, lines_cleared_total, White);
    update_label(Y_SCORE, score, White);

    // --- STEP 2: Generazione Nuovi PowerUP ---
    // (Generiamo su ciò che è rimasto dopo la pulizia base)
    if (lines_cleared_total % LINES_FOR_POWERUP == 0) {
         spawn_random_powerup();
    }

// --- STEP 3: Attivazione Effetti PowerUP ---
    // Avvengono DOPO che la riga trigger è sparita
    if (trigger_clear_half) {
        apply_clear_half(); // Rimuove metà delle righe RESTANTI
    }
    
    if (trigger_slow) {
        // CORREZIONE QUI:
        // Usiamo la variabile letta da game_update
        // 15 secondi * 40Hz = 600 ticks
        slow_powerup_timer = 600; 
    }

    // --- STEP 4: Applicazione Malus ---
    // Avviene per ULTIMO. Se ClearHalf ha pulito tutto, il Malus aggiungerà
    // una riga in fondo senza uccidere il giocatore.
    if (lines_cleared_total % LINES_FOR_MALUS == 0) {
         apply_malus();
    }

		// --- STEP 5: Ridisegno Finale OTTIMIZZATO ---
    // NON usiamo LCD_Clear o draw_board, perché ridisegnano la cornice inutilmente.
    // Ridisegniamo solo le celle della griglia di gioco.
    
    for (r = 0; r < Field_ROWS; r++) {
        for (c = 0; c < Field_COLS; c++) {
            // Questo ridisegna il blocco colorato, la lettera (se c'è) 
            // oppure il nero se la cella è vuota, pulendo "sporcizia" precedente.
            draw_grid_cell(r, c, board[r][c]);
        }
    }
}

void spawn_block(void) {
    int i;
    if (currentBlock.type == 0 && nextBlock.type == 0) {
        nextBlock.type = (BlockType)(rand() % 7);
        nextBlock.color = TETROMINO_COLORS[nextBlock.type];
        for(i=0; i<4; i++) nextBlock.cells[i] = TETROMINO_SHAPES[nextBlock.type][i];
    }
    currentBlock = nextBlock;
    currentBlock.position.row = 1;
    currentBlock.position.col = Field_COLS / 2;
    draw_block_preview(currentBlock, T_Black);

    nextBlock.type = (BlockType)(rand() % 7);
    nextBlock.color = TETROMINO_COLORS[nextBlock.type];
    for(i=0; i<4; i++) nextBlock.cells[i] = TETROMINO_SHAPES[nextBlock.type][i];
    draw_block_preview(nextBlock, nextBlock.color);
}

void lock_block(void) {
    int i, r, c;
    for (i = 0; i < 4; i++) {
        r = currentBlock.position.row + currentBlock.cells[i].row;
        c = currentBlock.position.col + currentBlock.cells[i].col;
        if (r >= 0 && r < Field_ROWS) board[r][c] = currentBlock.color;
    }
    score += 10;
    update_label(Y_SCORE, score, White);
    hard_drop_mode = 0;
    check_lines();
    spawn_block();
    
    if (check_collision(currentBlock)) {
        status = GAME_OVER;
        GUI_Text(50, 150, (uint8_t *)" GAME OVER ", Red, White);
        if (score > highScore) {
            highScore = score;
            update_label(Y_HISCORE, highScore, Yellow);
            GUI_Text(50, 170, (uint8_t *)"NEW RECORD!", Yellow, Black);
        }
        GUI_Text(30, 190, (uint8_t *)"PRESS KEY1", White, Black);
    } else {
        draw_tetromino(currentBlock, currentBlock.color);
    }
}

void rotate_block(void) {
    int i, tmp_r;
    Block temp;
    if (currentBlock.type == O_BLOCK) return;
    temp = currentBlock;
    for (i = 0; i < 4; i++) {
        tmp_r = temp.cells[i].row;
        temp.cells[i].row = temp.cells[i].col;
        temp.cells[i].col = -tmp_r;
    }
    if (!check_collision(temp)) {
        draw_tetromino(currentBlock, T_Black);
        currentBlock = temp;
        draw_tetromino(currentBlock, currentBlock.color);
    }
}

/* --- FUNZIONI PRINCIPALI --- */

void on_key1_pressed(void) {
    srand(LPC_TIM0->TC);
    if (status == GAME_OVER) {
        restart_requested = 1;
    } else if (status == GAME_PAUSED) {
        status = GAME_RUNNING;
        GUI_Text(UI_COL_X, Y_STATUS, (uint8_t *)"      ", Black, Black);
    } else {
        status = GAME_PAUSED;
        GUI_Text(UI_COL_X, Y_STATUS, (uint8_t *)"PAUSED", Yellow, Black);
    }
}

void game_init(void) {
    int i, j;
    NVIC_SetPriority(RIT_IRQn, 1);
    NVIC_SetPriority(TIMER0_IRQn, 2);
    for (i = 0; i < Field_ROWS; i++) {
        for (j = 0; j < Field_COLS; j++) board[i][j] = T_Black;
    }
    score = 0;
    lines_cleared_total = 0;
    status = GAME_PAUSED;
		// Pulizia Board e Board Powers
    for (i = 0; i < Field_ROWS; i++) {
        for (j = 0; j < Field_COLS; j++) {
            board[i][j] = T_Black;
            board_powers[i][j] = POWER_NONE;
        }
    }
    currentBlock.type = nextBlock.type = 0;
    LCD_Clear(T_Black);
    draw_board();
    spawn_block();
}

void game_update(void) {
    Block temp;
    int threshold;
    int base_delay;

    if (restart_requested) {
        restart_requested = 0;
        game_init();
        return;
    }
    if (status != GAME_RUNNING) return;

    // 1. Avvia conversione ADC (aggiorniamo sempre il valore hardware)
    ADC_start_conversion();

// 2. LOGICA VELOCITÀ (Priorità PowerUp > Potenziometro)
    if (slow_powerup_timer > 0) {
        // --- POWERUP ATTIVO ---
        base_delay = 40; // Forza velocità minima (1 blocco/sec)
        slow_powerup_timer--; // Decrementa il tempo rimanente
    } else {
        // --- NORMALE (CONTROLLO POTENZIOMETRO) ---
        base_delay = 40 - ((AD_current * 32) / 0xFFF);
        if (base_delay < 8) base_delay = 8; 
    }

    if (hard_drop_mode) {
        // ... (Logica Hard Drop invariata)
        draw_tetromino(currentBlock, T_Black);
        while (!check_collision(currentBlock)) currentBlock.position.row++;
        currentBlock.position.row--;
        draw_tetromino(currentBlock, currentBlock.color);
        lock_block();
        return;
    }
    
    // ... (Gestione Joystick Left/Right/Up invariata) ...
    if (J_up) { rotate_block(); J_up = 0; }
    if (J_left || J_right) {
        // ... (codice movimento laterale)
        temp = currentBlock;
        if (J_left)  temp.position.col--;
        if (J_right) temp.position.col++;
        if (!check_collision(temp)) {
            draw_tetromino(currentBlock, T_Black);
            currentBlock = temp;
            draw_tetromino(currentBlock, currentBlock.color);
        }
        J_left = J_right = 0;
    }

    drop_ticks++;

    // 3. Gestione Soft Drop (Joystick Down)
    // La specifica dice: "doubles the current falling speed"
    // Se siamo rallentati (base_delay = 40), premendo giù andiamo a 20 (2 blocchi/sec).
    if (J_down) {
        threshold = base_delay / 2;
        if (threshold < 1) threshold = 1;
    } else {
        threshold = base_delay;
    }

    if (drop_ticks >= threshold) {
        drop_ticks = 0;
        // ... (Logica caduta blocco invariata)
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