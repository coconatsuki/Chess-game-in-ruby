require './matrix'

class Board
  attr_accessor :matrix

  def initialize
    @matrix = Matrix.new
    install_game
  end

  def available?(new_position)
    col = new_position[0]
    row = new_position[1]
    unless  @matrix.available?(col, row)
      Ui.print_non_available_message
      false
    end
  end

  def move_piece(piece_position, new_position)
    piece = @matrix[piece_position[0], piece_position[1]]
    @matrix.play(piece, new_position[0], new_position[1])
    remove_piece(piece_position)
  end

  def remove_piece(piece_position)
    @matrix.remove(piece_position[0], piece_position[1])
  end

  #installation of the board :

  def install_game
    install_pawns
    install_rooks
    install_knights
    install_bishops
    install_kings
    install_queens
  end

  def install_pawns
    8.times do |i|
       @matrix[i, 1] = Pawn.new(:white, [i, 1])
    end
    8.times do |i|
       @matrix[i, 6] = Pawn.new(:black, [i, 6])
    end
  end

  def install_rooks
    @matrix[0, 0] = Rook.new(:white, [0, 0])
    @matrix[7, 0] = Rook.new(:white, [7, 0])
    @matrix[0, 7] = Rook.new(:black, [0, 7])
    @matrix[7, 7] = Rook.new(:black, [7, 7])
  end

  def install_knights
    @matrix[1, 0] = Knight.new(:white, [1, 0])
    @matrix[6, 0] = Knight.new(:white, [6, 0])
    @matrix[1, 7] = Knight.new(:black, [1, 7])
    @matrix[6, 7] = Knight.new(:black, [6, 7])
  end

  def install_bishops
    @matrix[2, 0] = Bishop.new(:white, [2, 0])
    @matrix[5, 0] = Bishop.new(:white, [5, 0])
    @matrix[2, 7] = Bishop.new(:black, [2, 7])
    @matrix[5, 7] = Bishop.new(:black, [5, 7])
  end

  def install_queens
    @matrix[3, 0] = Queen.new(:white, [3, 0])
    @matrix[3, 7] = Queen.new(:black, [3, 7])
  end

  def install_kings
    @white_king = King.new(:white, [4, 0])
    @black_king = King.new(:black, [4, 7])
    @matrix[4, 0] = @white_king
    @matrix[4, 7] = @black_king
  end
end
