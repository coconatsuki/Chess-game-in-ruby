require './matrix'

class Piece
  attr_accessor :color, :position, :never_moved

  def initialize(color, position)
    @color = color
    @position = position
    #@never_moved = true
  end

  def to_s
    if @color == :white
      self.class::WHITE
    else
      self.class::BLACK
    end
  end

  def not_out_of_range?(target)
    target.all? { |num| num >= 0 && num < 8 }
  end

  def destination_ok?(board, col, row)
    board.matrix[col, row].nil? || board.matrix[col, row].color != self.color
  end

  def target_occupied_by_ennemy?(target, board)
    col = target[0]
    row = target[1]
    board.matrix[col, row] && board.matrix[col, row].color != self.color
  end

  def path_ok?(target, x, y, path_array)
    if move_only_one_step(target, x, y)
      true
    else
      path_free?(path_array)
    end
  end

  def path(starting, ending, board)
    if starting[0] == ending[0]
      column_path(starting, ending, board)
    elsif starting[1] == ending[1]
      row_path(starting, ending, board)
    else
      diagonal_path(starting, ending, board)
    end
  end

  def path_free?(path_array)
    path_array.all? { |box| box.nil? }
  end

##############
#to get the different paths,
#so we can check that there's no piece on the way (that all squares are nil).

  def column_path(starting, ending, board)
    if starting[1] < ending[1]
      board.matrix.part_of_col_up(starting, ending)
    else
      board.matrix.part_of_col_down(starting, ending)
    end
  end

  def row_path(starting, ending, board)
    if starting[0] < ending[0]
      board.matrix.part_of_row_right(starting, ending)
    else
      board.matrix.part_of_row_left(starting, ending)
    end
  end

  def diagonal_path(starting, ending, board)
    if starting[0] < ending[0] && starting[0] < ending[0]
      board.matrix.part_of_diag_r_up(starting, ending)
    elsif starting[0] > ending[0] && starting[0] > ending[0]
      board.matrix.part_of_diag_r_down(starting, ending)
    elsif starting[0] > ending[0] && starting[1] < ending[0]
      board.matrix.part_of_diag_l_up(starting, ending)
    else
      board.matrix.part_of_diag_l_down(starting, ending)
    end
  end
  ###############
  #to construct the queen's, rook's and bishop's possible_moves :

  def rows_from_starting_point(starting_x, starting_y)
    (starting_x..7).each { |x| @possible_moves << [x, starting_y] }
    (0..starting_x).each { |x| @possible_moves << [x, starting_y] }
  end

  def columns_from_starting_point(starting_x, starting_y)
    (starting_y..7).each { |y| @possible_moves << [starting_x, y]}
    (0..starting_y).each { |y| @possible_moves << [starting_x, y]}
  end

  def right_up_diagonal
    x = @position[0]
    y = @position[1]
    while x < 8 && y < 8
      @possible_moves << [x, y]
      x += 1
      y += 1
    end
  end

  def left_down_diagonal
    x = @position[0]
    y = @position[1]
    while x >= 0 && y >= 0
      @possible_moves << [x, y]
      x -= 1
      y -= 1
    end
  end

  def left_up_diagonal
    x = @position[0]
    y = @position[1]
    while x >= 0 && y < 8
      @possible_moves << [x, y]
      x -= 1
      y += 1
    end
  end

  def right_down_diagonal
    x = @position[0]
    y = @position[1]
    while x < 8 && y >= 0
      @possible_moves << [x, y]
      x += 1
      y -= 1
    end
  end
end
