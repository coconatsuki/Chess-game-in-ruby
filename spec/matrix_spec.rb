require './matrix'


describe Matrix do

  context ".create_box" do
    it "creates a 8x8 grid" do
      expect(subject.boxes.flatten.size).to eql(64)
    end
  end

  context ".[]=" do
    it "insert a value in a box" do
      subject[1, 2] = 8
      expect(subject.boxes[1][2]).to eql(8)
    end
  end

  context ".[]" do
    it "reads a box" do
      subject[1, 2] = 8
      expect(subject[1, 2]).to eql(8)
    end
  end

  context ".col" do
    it "returns a column" do
      subject[1, 2] = 8
      expect(subject.col(1)).to eql([nil, nil, 8, nil, nil, nil, nil, nil])
    end
  end

  context ".row" do
    it "returns a row" do
      subject[1, 2] = 8
      expect(subject.row(2)).to eql([nil, 8, nil, nil, nil, nil, nil, nil])
    end
  end

  context ".diag_x" do
    it "returns a diag_r" do
      subject[4, 1] = 8
      expect(subject.diag_r(3)).to eql([nil, 8, nil, nil, nil])
    end

    it "returns a diag_l" do
      subject[4, 1] = 8
      expect(subject.diag_l(5)).to eql([nil, 8, nil, nil, nil, nil])
    end
  end

  context ".cols" do
    it "returns all columns" do
      expect(subject.cols).to eql(subject.boxes)
    end
  end

  context ".rows" do
    it "returns all rows" do
      expect(subject.rows).to eql(Matrix.new.boxes)
    end
  end

  context ".diags" do
    it "returns all diagonals" do
      expect(subject).to receive(:diag_l).exactly(8).times
      expect(subject).to receive(:diag_r).exactly(8).times
      expect(subject.diags.size).to eql(16)
    end
  end

  context ".available?" do
    it "returns true if there's an empty box in a column" do
      expect(subject.available?(1, 2)).to be true
    end

    it "returns false if a box is occupied" do
      subject[1, 2] = 'X'
      expect(subject.available?(1, 2)).to be false
    end
  end

  context ".part_of_col_up" do
    it "returns an array containing an up-part of a column" do
      expect(subject.part_of_col_up([3, 4], [3, 7]).size).to eql(2)
    end
  end

  context ".part_of_col_down" do
    it "returns an array containing a down-part of a column" do
      expect(subject.part_of_col_down([3, 4], [3, 1]).size).to eql(2)
    end
  end

  context ".part_of_row_right" do
    it "returns an array containing a left-part of a column" do
      expect(subject.part_of_row_right([3, 3], [6, 3]).size).to eql(2)
    end
  end

  context ".part_of_row_left" do
    it "returns an array containing a right-part of a column" do
      expect(subject.part_of_row_left([3, 3], [0, 3]).size).to eql(2)
    end
  end

  context ".part_of_diag_r_up" do
    it "returns an array containing an up-part of a right-diagonal" do
      expect(subject.part_of_diag_r_up([3, 3], [6, 6]).size).to eql(2)
    end
  end

  context ".part_of_diag_r_down" do
    it "returns an array containing a down-part of a right-diagonal" do
      expect(subject.part_of_diag_r_down([3, 3], [0, 0]).size).to eql(2)
    end
  end

  context ".part_of_diag_l_up" do
    it "returns an array containing an up-part of a left-diagonal" do
      expect(subject.part_of_diag_l_up([3, 3], [0, 6]).size).to eql(2)
    end
  end

  context ".part_of_diag_l_down" do
    it "returns an array containing a down-part of a right-diagonal" do
      expect(subject.part_of_diag_l_down([3, 3], [6, 0]).size).to eql(2)
    end
  end
end
