from functools import reduce
from typing import List, Tuple

def is_safe(board: List[int], row: int) -> bool:
    for i in range(row):
        if (board[i] == board[row]) or \
                (abs(board[i] - board[row]) == row - i):
            return False
    return True

def place_queen_and_check(board: List[int], row: int, column: int) -> Tuple[bool, List[int]]:
    new_board = board[:]  # Make a copy to avoid mutation of the original board.
    new_board[row] = column
    return (is_safe(new_board, row), new_board)

def board_extend(boards: List[List[int]], row: int) -> List[List[int]]:
    N = 8  # Size of the board (8x8)
    new_boards = []
    for board in boards:
        # Generate all possible new boards for the current row
        possible_boards = [(place_queen_and_check(board, row, col)) for col in range(N)]
        # Use filter to include only the boards with safe queen placement
        safe_boards = list(filter(lambda x: x[0], possible_boards))
        # Extract the board configurations from the filtered tuples
        new_boards.extend([board for (safe, board) in safe_boards])
    return new_boards

# Start with an empty board configuration
N = 8  # Defining N for clarity, as it is used multiple times
initial_board: List[int] = [-1] * N
current_boards: List[List[int]] = [initial_board]

current_boards = reduce(board_extend, range(N), current_boards)
# Now, current_boards should have all solutions for the 8 queens problem
print(f"Number of solutions: {len(current_boards)}")
print(current_boards[0])