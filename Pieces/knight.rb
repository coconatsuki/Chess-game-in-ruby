require 'pry'
require_relative './piece'

class Knight  < Piece
  WHITE = '♘'
  BLACK = '♞'

  def initialize(color, position)
    super
  end

  def valid_move?(board, target)
    x = @position[0]
    y = @position[1]
    moves = [
    [x + 2, y - 1],
    [x + 2, y + 1],
    [x - 2, y - 1],
    [x - 2, y + 1],
    [x + 1, y - 2],
    [x + 1, y + 2],
    [x - 1, y - 2],
    [x - 1, y + 2],
  ]

    moves.include?(target) &&
    destination_ok?(board, target[0], target[1])
  end
end
