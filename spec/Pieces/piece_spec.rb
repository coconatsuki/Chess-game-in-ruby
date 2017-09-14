require './Pieces/piece'
require './matrix'

describe Piece do
  subject do
    Piece.new(:white, [3, 3])
  end

  context ".path_free?" do
    it "returns true if the path is free" do
      expect(subject.path_free?([nil, nil, nil])).to be true
      subject.path_free?([nil, nil, nil])
    end

    it "returns false if some piece is on the path" do
      expect(subject.path_free?([nil, 'piece', nil])).to be false
      subject.path_free?([nil, 'piece', nil])
    end
  end
end
