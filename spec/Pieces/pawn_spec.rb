require './Pieces/pawn'
require 'pry'

describe Pawn do
  before do
    @board = double
    matrix = double
    allow(@board).to receive(:matrix)
    allow(@board.matrix).to receive(:part_of_col_up)
    allow(@board.matrix).to receive(:part_of_col_down)
    allow(@board.matrix).to receive(:[])
    allow(subject).to receive(:unoccupied_destination?).and_return true
    allow(subject).to receive(:path_free?).and_return true
    allow(subject).to receive(:target_occupied_by_ennemy?).and_return false
  end

  context "in the middle of the @board" do
    context "vertical_move" do
      context "for a white pawn" do
        subject do
          Pawn.new(:white, [5, 3])
        end
        it "moves only one square up, vertical, if there's no ennemy" do
          expect(subject.valid_move?(@board, [5, 4])).to be true
        end

        it "returns false if a pawn tries to go up while there's an enemy" do
          allow(subject).to receive(:unoccupied_destination?).and_return false
          allow(subject).to receive(:target_occupied_by_ennemy?).and_return true
          expect(subject.valid_move?(@board, [5, 4])).to be false
        end

        it "returns false if we move too far up" do
          expect(subject.valid_move?(@board, [5, 5])).to be false
        end
      end
      context "for a black pawn" do
        subject do
          Pawn.new(:black, [3, 4])
        end
        it "moves one square down, vertical, if there's no ennemy" do
          expect(subject.valid_move?(@board, [3, 3])).to be true
        end

        it "returns false if we move too far down" do
          expect(subject.valid_move?(@board, [3, 2])).to be false
        end
      end
    end
  end

    context "eating_move" do
      context "for a white pawn" do
        subject do
          Pawn.new(:white, [5, 1])
        end
        it "cannot go to the diagonal if there's no ennemy" do
          expect(subject.valid_move?(@board, [6, 2])).to be false
        end
        it "eats an ennemy on a right-up diagonal" do
          allow(subject).to receive(:unoccupied_destination?).and_return false
          allow(subject).to receive(:target_occupied_by_ennemy?).and_return true
          expect(subject.valid_move?(@board, [6, 2])).to be true
        end
      end
      context "for a black pawn" do
        subject do
          Pawn.new(:black, [3, 5])
        end
        it "cannot go to the diagonal if there's no ennemy" do
          expect(subject.valid_move?(@board, [2, 4])).to be false
        end
        it "eats an ennemy on a left-down diagonal" do
          allow(subject).to receive(:unoccupied_destination?).and_return false
          allow(subject).to receive(:target_occupied_by_ennemy?).and_return true
          expect(subject.valid_move?(@board, [2, 4])).to be true
        end
      end

      context "in the first 2 rows" do
        context "for a white pawn" do
          subject do
            Pawn.new(:white, [5, 1])
          end
          it "can move 1 square up" do
            expect(subject.valid_move?(@board, [5, 2])).to be true
          end

          it "checks that it can move 2 squares up" do
            expect(subject.valid_move?(@board, [5, 3])).to be true
          end

          it "cannot go further than 2 squares up" do
            expect(subject.valid_move?(@board, [5, 4])).to be false
          end

          it "checks that it cannot move up if there's an ennemy on the target" do
            allow(subject).to receive(:unoccupied_destination?).and_return false
            expect(subject.valid_move?(@board, [5, 3])).to be false
          end
          it "checks that it cannot move up if there's an ennemy on the path" do
            allow(subject).to receive(:unoccupied_destination?).and_return false
            allow(subject).to receive(:target_occupied_by_ennemy?).and_return true
            expect(subject.valid_move?(@board, [5, 3])).to be false
          end
        end

        context "for a black pawn" do
          subject do
            Pawn.new(:black, [3, 6])
          end
          it "checks that it can move one square down" do
            expect(subject.valid_move?(@board, [3, 5])).to be true
          end
          it "checks that it can move 2 squares down" do
            expect(subject.valid_move?(@board, [3, 4])).to be true
          end
          it "cannot go further than 2 squares down" do
            expect(subject.valid_move?(@board, [5, 3])).to be false
          end
        end
      end
    end
  end
