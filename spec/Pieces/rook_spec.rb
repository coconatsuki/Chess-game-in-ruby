require './Pieces/rook'
require 'pry'

describe Rook do
  subject do
    Rook.new(:white, [3, 3])
  end
  context ".possible_moves" do
    it "returns an array with all possible moves" do
      subject.valid_move_aux
      expect(subject.possible_moves.size).to eql(14)
    end
  end

end
