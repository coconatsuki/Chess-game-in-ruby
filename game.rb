require './board'
require './ui'
require './Pieces/piece'
require './Pieces/pawn'
require './Pieces/bishop'
require './Pieces/king'
require './Pieces/queen'
require './Pieces/knight'
require './Pieces/rook'

class Game
  attr_accessor :board, :white, :black

  def initialize
    @board = Board.new
    @white = :white
    @black = :black
  end

  def launch_game
    Ui.load_question
    game
    winner = who_wins if victory?
    end_game(winner)
    exit_now
  end

  def game
    while !victory?
      Ui.save_game_question
      one_turn(white)
      one_turn(black) if !victory?
    end
  end

  def one_turn(player)
    Ui.board_display(@board)
    piece_position = ask_piece_position(player)
    new_position = ask_new_position(piece_position, player)
    if new_position.nil?
      one_turn(player)
    else
      move_piece(piece_position, new_position)
    end
  end

  def ask_piece_position(player)
    piece_position = Ui.choose_piece_position(player)
    square_content = @board.matrix[piece_position[0], piece_position[1]]
    piece_position = valid_piece(square_content, piece_position, player)
  end

  def valid_piece(square_content, piece_position, player)
    if square_content.nil?
      piece_position = ask_again_if_empty_square(square_content, player)
    elsif square_content && square_content.color != player
        piece_position = ask_again_if_wrong_color(player)
    else
      piece_position
    end
  end

  def ask_again_if_empty_square(square_content, player)
      Ui.board_display(@board)
      Ui.empty_square_message
      ask_piece_position(player)
  end

  def ask_again_if_wrong_color(player)
    Ui.board_display(@board)
    Ui.wrong_player_message(player)
    ask_piece_position(player)
  end

  def ask_new_position(piece_position, player)
    piece = @board.matrix[piece_position[0], piece_position[1]]
    new_position = Ui.choose_new_position(player, piece)
    return nil if new_position.nil?
    if !piece.valid_move?(@board, new_position)
      Ui.wrong_move_message
      new_position = ask_new_position(piece_position, player)
    end
    new_position
  end

  def valid_move?(piece, new_position)
    piece.valid_move?(@board, new_position)
  end

  def move_piece(piece_position, new_position)
    @board.move_piece(piece_position, new_position)
  end

  def end_game(winner)
    if victory?
      Ui.board_display(@board)
      Ui.victory_message(winner)
    end
  end

  def victory?
    !(any_white_king? && any_black_king?)
  end

  def who_wins
    "white" if !any_black_king?
    "black" if !any_white_king?
  end

    def any_white_king?
      board_squares.any? do |square|
        square.is_a?(King) && square.color == :white
      end
    end

    def any_black_king?
      board_squares.any? do |square|
        square.is_a?(King) && square.color == :black
      end
    end

    def board_squares
      @board.matrix.boxes.flatten
    end

  def exit_now
    exit
  end
end
