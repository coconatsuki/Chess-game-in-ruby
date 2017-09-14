require './board'

class Ui

  def self.victory_message(winner)
    puts '-----------------------------------------------------'
    puts "THE #{winner.upcase} PLAYER WINS !! CONGRATULATION !"
    puts '-----------------------------------------------------'
  end

  def self.game_over_message
    puts "No one wins. Sorry... Try again !"
  end

  def self.not_valid_message
    puts "\nI didn't get this. Could you repeat ?"
    puts "You need to write a number between 0 and 7"
  end

  def self.print_non_available_message
    puts '-----------------------------------------------------'
    puts '==> Sorry, this box is occupied. Please choose an other one !'
    puts '-----------------------------------------------------'
  end

  def self.choose_piece_position(player)
    puts "\n===> Please, choose a #{player.upcase} piece."
    choose_box(player)
  end

  def self.choose_new_position(player, piece)
    puts '--------------------------------------------------------------'
    puts "===> Where do you want to move your --#{player.upcase} #{piece.class.name.upcase} #{piece} #{piece.position}-- ?"
    puts '--------------------------------------------------------------'
    puts "(If you want to cancel and choose an other piece, write 'CANCEL'."
    choose_box(player)
  end

  def self.choose_box(player)
    puts "\nWrite a column and a row number separated with a comma, like that : '1, 4'."
    nums = gets.chomp
    return nil if nums.upcase == 'CANCEL'
    @nums_array = nums.split(',')
    if @nums_array.size != 2
      wrong_choice(player)
      choose_box(player)
    else
      @nums_array.map! do |num|
        if num =~ /[0-7]/
          num.to_i
        else
          wrong_choice(player)
          choose_box(player)
        end
      end
    end
    @nums_array
  end

  def self.wrong_choice(player)
    puts '-----------------------------------------------------'
    puts "==> Sorry, you made a mistake. Please do it again."
    puts '-----------------------------------------------------'
  end

  def self.empty_square_message
    puts '-----------------------------------------------------'
    puts "\n==> Sorry, this square is empty."
    puts '-----------------------------------------------------'
  end

  def self.wrong_player_message(player)
    puts '-----------------------------------------------------'
    puts "\n==> Sorry, this piece isn't one of yours. You have to choose a #{player} piece."
    puts '-----------------------------------------------------'
  end

  def self.wrong_move_message
    puts '-----------------------------------------------------'
    puts "\n==> Sorry, you cannot move your piece on that square."
    puts '-----------------------------------------------------'
  end

  def self.print_eating_message
    puts '-----------------------------------------------------'
    puts "==> Congrats, you ate an ennemy's piece !!"
  end

    def self.board_display(board)
      puts "  ---------------------------------"
      7.downto(0) do |i|
        row_string = row_to_s(board.matrix.row(i))
        if i == 7
          puts "#{i} | #{row_string.join(' | ')} | BLACK"
        elsif i == 0
          puts "#{i} | #{row_string.join(' | ')} | WHITE"
        else
          puts "#{i} | #{row_string.join(' | ')} |"
          puts "  ---------------------------------"
        end
      end
      puts "    0   1   2   3   4   5   6   7"
    end

    def self.row_to_s(row)
      row.map do |el|
        el.nil? ? ' ' : el
      end
    end
  end
