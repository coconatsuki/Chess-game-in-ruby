require './Pieces/bishop'
require 'pry'

describe Bishop do
  subject do
    Bishop.new(:white, [3, 4])
  end
  context ".possible_moves" do
    it "returns an array with all possible moves" do
      subject.valid_move_aux
      expect(subject.possible_moves.size).to eql(13)
    end
  end

end
