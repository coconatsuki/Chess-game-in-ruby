require './Pieces/queen'
require 'pry'

describe Queen do
  subject do
    Queen.new(:white, [3, 3])
  end
  context ".possible_moves" do
    it "returns an array with all possible moves" do
      subject.valid_move_aux
      expect(subject.possible_moves.size).to eql(27)
    end
  end

end
