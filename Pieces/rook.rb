class Rook  < Piece
  WHITE = '♖'
  BLACK = '♜'

  attr_accessor :possible_moves

  def initialize(color, position)
    super
    @possible_moves = []
  end

  #target_occupied_by_ennemy?(target, board)

  def valid_move?(board, target)
    x = @position[0]
    y = @position[1]
    @possible_moves = []
    valid_move_aux
    path_array = path(@position, target, board)
    @possible_moves.include?(target) &&
    destination_ok?(board, target[0], target[1]) &&
    path_ok?(target, x, y, path_array)
  end

  def valid_move_aux
    starting_x = @position[0]
    starting_y = @position[1]
    #row :
    (starting_x..7).each { |x| @possible_moves << [x, starting_y] }
    (0..starting_x).each { |x| @possible_moves << [x, starting_y] }
    #column :
    (starting_y..7).each { |y| @possible_moves << [starting_x, y]}
    (0..starting_y).each { |y| @possible_moves << [starting_x, y]}
    @possible_moves.delete(@position)
  end

  def move_only_one_step(target, x, y)
    one_step_moves = [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]]
    one_step_moves.include?(target)
  end
end
