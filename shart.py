import pyautogui
import time

text = '''
import random

board = [[' ' for _ in range(3)] for _ in range(3)]

def play_tic_tac_toe(row, col):
    if board[row][col] == ' ':
        board[row][col] = 'X'
    else:
        print("That spot is already taken.")
        return False
    return True

def check_win():
    # check rows
    for i in range(3):
        if board[i][0] == board[i][1] == board[i][2] and board[i][0] != ' ':
            return board[i][0]
    # check columns
    for i in range(3):
        if board[0][i] == board[1][1] == board[2][i] and board[0][i] != ' ':
            return board[0][i]
    # check diagonals
    if board[0][0] == board[1][1] == board[2][2] and board[0][0] != ' ':
        return board[0][0]
    if board[0][2] == board[1][1] == board[2][0] and board[0][2] != ' ':
        return board[0][2]
    # check tie
    if ' ' not in [item for sublist in board for item in sublist]:
        return "TIE"
    return None

def onMousePress(mouseX, mouseY):
    row, col = mouseY // 133, mouseX // 133
    if play_tic_tac_toe(row, col):
        winner = check_win()
        if winner:
            print(f"{winner} wins!" if winner != "TIE" else "It's a tie!")
            return

        ai_row, ai_col = random.choice([(i, j) for i in range(3) for j in range(3) if board[i][j] == ' '])
        play_tic_tac_toe(ai_row, ai_col)
        winner = check_win()
        if winner:
            print(f"{winner} wins!" if winner != "TIE" else "It's a tie!")
            return

    for i in range(3):
        for j in range(3):
            if board[i][j] == 'X':
                Label('X', j*133 + 67, i*133 + 67, fill='black', size=40)
            elif board[i][j] == 'O':
                Label('O', j*133 + 67, i*133 + 67, fill='black', size=40)
'''
time.sleep(2)
for char in text:
    pyautogui.typewrite(char)
    if char == '\n':
        pyautogui.press("enter")
    if char == ':':
        pyautogui.press("tab")