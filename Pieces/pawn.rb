class Pawn  < Piece
  WHITE = '♙'
  BLACK = '♟'

  attr_accessor :position, :color

  def initialize(color, position)
    super
  end

  def valid_move?(board, target)
    x = @position[0]
    y = @position[1]
    pawn_path = find_path(target, x, y) if (y + 2 == target[1]) || (y - 2 == target[1])
    not_out_of_range?(target) &&
    different_from_actual_position?(x, y, target) &&
    valid_move_aux?(x, y, board, target, pawn_path)
  end

  #private

  def find_path(target, x, y)
    if y + 2 == target[1]
      result = [x, y + 1]
    else
      result = [x, y - 1]
    end
  end

  def path_free?(board, pawn_path)
    board.matrix[pawn_path[0], pawn_path[1]].nil?
  end

  def valid_move_aux?(x, y, board, target, pawn_path)
    if target_in_same_column?(x, y, target)
      valid_normal_move?(x, y, board, target, pawn_path)
    else
      valid_eating_move?(x, y, target, board)
    end
  end

  def valid_normal_move?(x, y, board, target, pawn_path)
    valid_column_move?(x, y, board, target, pawn_path) &&
    unoccupied_destination?(target, board)
  end

  def valid_column_move?(x, y, board, target, pawn_path)
    if move_more_than_2_steps?(x, y, target)
      false
    elsif never_moved?(x, y)
      (move_one_step_forward?(x, y, target)) ||
      (move_two_steps_forward?(x, y, target) if path_free?(board, pawn_path))
    else
      move_one_step_forward?(x, y, target)
    end
  end

  def valid_eating_move?(x, y, target, board)
    target_in_a_close_diagonal?(x, y, target) && target_occupied_by_ennemy?(target, board)
  end

  #checking smaller conditions :

  def different_from_actual_position?(x, y, target)
    !(x == target[0] && y == target[1])
  end

  def never_moved?(x, y)
    y == 1 || y == 6
  end

  def target_in_same_column?(x, y, target)
    target[0] == x
  end

  def target_in_a_close_diagonal?(x, y, target)
    if color == :white
     (target[0] == x + 1 && target[1] == y + 1) ||
     (target[0] == x - 1 && target[1] == y + 1)
    else
      (target[0] == x + 1 && target[1] == y - 1) ||
      (target[0] == x - 1 && target[1] == y - 1)
    end
  end

  def unoccupied_destination?(target, board)
    board.matrix[target[0], target[1]].nil?
  end

  def move_two_steps_forward?(x, y, target)
    if color == :white
     target[1] == y + 2
    else
      target[1] == y - 2
    end
  end

  def move_one_step_forward?(x, y, target)
    if color == :white
     target[1] == y + 1
    else
      target[1] == y - 1
    end
  end

  def move_more_than_2_steps?(x, y, target)
    if color == :white
     target[1] > y + 2
     else
      target[1] < y - 2
    end
  end
end
