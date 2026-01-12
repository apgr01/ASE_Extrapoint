#include "game.h"
#include "LPC17xx.h"
#include <stdlib.h>
#include <stdio.h>

/* --- COSTANTI INTERFACCIA --- */
#define UI_COL_X             160
#define Y_SCORE              40
#define Y_LINES              90
#define Y_HISCORE            140
#define Y_STATUS             265
#define DROP_DELAY_NORMAL    40
#define DROP_DELAY_FAST      2

/* --- VARIABILI GLOBALI --- */
uint16_t board[Field_ROWS][Field_COLS];
Block currentBlock, nextBlock;
volatile GameStatus status = GAME_PAUSED;

int score = 0;
int lines_cleared_total = 0;
volatile int highScore = 0;

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
    
    for (i = 0; i < BLOCK_SIZE; i++) {
        for (j = 0; j < BLOCK_SIZE; j++) {
            uint16_t p_color = (i == BLOCK_SIZE - 1 || j == BLOCK_SIZE - 1) ? T_Black : color;
            LCD_SetPoint(x0 + j, y0 + i, p_color);
        }
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
    
    for (r = Field_ROWS - 1; r >= 0; r--) {
        full = 1;
        for (c = 0; c < Field_COLS; c++) {
            if (board[r][c] == T_Black) { full = 0; break; }
        }
        if (full) {
            lines_found++;
            for (k = r; k > 0; k--) {
                for (c = 0; c < Field_COLS; c++) board[k][c] = board[k-1][c];
            }
            for (c = 0; c < Field_COLS; c++) board[0][c] = T_Black;
            r++; 
        }
    }
    if (lines_found > 0) {
        lines_cleared_total += lines_found;
        score += (lines_found == 4) ? 600 : (lines_found * 100);
        update_label(Y_LINES, lines_cleared_total, White);
        update_label(Y_SCORE, score, White);
        for (r = 0; r < Field_ROWS; r++) {
            for (c = 0; c < Field_COLS; c++) draw_grid_cell(r, c, board[r][c]);
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
    currentBlock.type = nextBlock.type = 0;
    LCD_Clear(T_Black);
    draw_board();
    spawn_block();
}

void game_update(void) {
    Block temp;
    int threshold;

    if (restart_requested) {
        restart_requested = 0;
        game_init();
        return;
    }
    if (status != GAME_RUNNING) return;

    if (hard_drop_mode) {
        draw_tetromino(currentBlock, T_Black);
        while (!check_collision(currentBlock)) currentBlock.position.row++;
        currentBlock.position.row--;
        draw_tetromino(currentBlock, currentBlock.color);
        lock_block();
        return;
    }

    if (J_up) { rotate_block(); J_up = 0; }
    if (J_left || J_right) {
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
    threshold = (J_down) ? DROP_DELAY_FAST : DROP_DELAY_NORMAL;
    if (drop_ticks >= threshold) {
        drop_ticks = 0;
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