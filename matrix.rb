require 'pry'

class Matrix
  attr_accessor :boxes

  def initialize
    @boxes = create_box
  end

  def create_box
    grid = Array.new(8)
    grid.map! { |box| Array.new(8) }
  end

  def []=(column, row, value)
    @boxes[column][row] = value
  end

  def [](column, row)
    @boxes[column][row]
  end

##########################
# methods useful for the Chess game :

    def available?(column, row)
      @boxes[column][row].nil?
    end

    def play(piece, col, row)
      if !available?(col, row)
        remove(col, row)
        Ui.print_eating_message
      end
      self[col, row] = piece
      piece.position = [col, row]
      become_queen(piece) if piece.is_a?(Pawn) && pawn_reached_opposite_row?(piece, row)
    end

    def remove(col, row)
      self[col, row] = nil
    end

    def out_of_range(column, row)
      raise "#{column} is out of range" if column < 0 || column >= @boxes.size
      raise "#{row} is out of range" if row < 0 || row >= @boxes[0].size
    end

    def become_queen(piece)
      x = piece.position[0]
      y = piece.position[1]
      if piece.color == :white
        self[x, y] = Queen.new(:white, [x, y])
      else
        self[x, y] = Queen.new(:black, [x, y])
      end
      Ui.pawn_became_queen_message
    end

    def pawn_reached_opposite_row?(piece, row)
      piece.color == :white && row == 7 ||
      piece.color == :black && row == 0
    end

##########################
# To get the whole columns, rows and diagonals :

    def col(num)
      @boxes[num]
    end

    def row(num)
      @boxes.map{ |el|  el[num] }
    end

  def diag_r(num)
    col = num
    row = 0
    result = []
    while col < @boxes.size && row < @boxes[0].size
      result << @boxes[col][row]
      col += 1
      row += 1
    end
    result
  end

    def diag_l(num)
      col = num
      row = 0
      result = []
      while col >= 0 && row < @boxes[0].size
        result << @boxes[col][row]
        col -= 1
        row += 1
      end
      result
    end

  def diag_r_up(col, row)
    result = []
    while col < @boxes.size && row < @boxes[0].size
      result << @boxes[col][row]
      col += 1
      row += 1
    end
    result
  end

    def diag_r_down(col, row)
      result = []
      while col >= 0 && row >= 0
        result << @boxes[col][row]
        col -= 1
        row -= 1
      end
      result
  end

  def diag_l_up(col, row)
    result = []
    while col >= 0 && row < @boxes[0].size
      result << @boxes[col][row]
      col -= 1
      row += 1
    end
    result
  end

  def diag_l_down(col, row)
    col = num
    row = 0
    result = []
    while col < @boxes.size && row >= 0
      result << @boxes[col][row]
      col += 1
      row -= 1
    end
    result
  end

  def cols
    @boxes
  end

  def rows
    result = []
    @boxes[0].size.times do |i|
      result << row(i)
    end
    result
  end

  def diags
    result = []
    @boxes.size.times do |i|
      result << diag_l(i) << diag_r(i)
    end
    result
  end
  #######################
  #To get parts of columns, row, and diagonals :

  def part_of_col_up(starting, ending)
    if starting[1] + 1 == ending[1] - 1
      [self[starting[0], starting[1] + 1]]
    else
      col(starting[0])[(starting[1] + 1)..(ending[1] - 1)]
    end
  end

  def part_of_col_down(starting, ending)
    if ending[1] + 1 == starting[1] - 1
      [self[starting[0], ending[1] + 1]]
    else
      col(starting[0])[(ending[1] + 1)..(starting[1] - 1)]
    end
  end

  def part_of_row_right(starting, ending)
    if starting[0] + 1 == ending[0] - 1
      [self[starting[0] + 1, starting[1]]]
    else
      row(starting[1])[(starting[0] + 1)..(ending[0] - 1)]
    end
  end

  def part_of_row_left(starting, ending)
    if ending[0] + 1 == starting[0] - 1
      [self[ending[0] + 1, starting[1]]]
    else
      row(starting[1])[(ending[0] + 1)..(starting[0] -1)]
    end
  end

  def part_of_diag_r_up(starting, ending)
    result = []
    x = starting[0] + 1
    y = starting[1] + 1
    while x < ending[0]
      result << @boxes[x][y]
      x += 1
      y += 1
    end
    result
  end

  def part_of_diag_r_down(starting, ending)
    result = []
    x = starting[0] - 1
    y = starting[1] - 1
    while x > ending[0]
      result << @boxes[x][y]
      x -= 1
      y -= 1
    end
    result
  end

  def part_of_diag_l_up(starting, ending)
    result = []
    x = starting[0] - 1
    y = starting[1] + 1
    while x > ending[0] && y < ending[1]
      result << @boxes[x][y]
      x -= 1
      y += 1
    end
    result
  end

  def part_of_diag_l_down(starting, ending)
    result = []
    x = starting[0] + 1
    y = starting[1] - 1
    while x < ending[0] && y > ending[1]
      result << @boxes[x][y]
      x += 1
      y -= 1
    end
    result
  end
end
