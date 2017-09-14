require 'pry'

class King  < Piece
  WHITE = '♔'
  BLACK = '♚'

  def initialize(color, position)
    super
    @possible_moves = []
  end

  def valid_move?(board, target)
    x = @position[0]
    y = @position[1]
    @possible_moves = []
    possible_moves_calcul(x, y)
    valid_move_aux?(target) &&
    not_out_of_range?(target) &&
    destination_ok?(board, target[0], target[1])
  end

  def valid_move_aux?(target)
    @possible_moves.include?(target)
  end

  def possible_moves_calcul(x, y)
  @possible_moves = [
    [x + 1, y],
    [x - 1, y],
    [x, y + 1],
    [x, y - 1],
    [x + 1, y + 1],
    [x - 1, y - 1],
    [x - 1, y + 1],
    [x + 1, y - 1]
    ]
  end
end
