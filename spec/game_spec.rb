require './game'

describe Game do
  context ".initialize" do
    it "creates a Board" do
      expect(subject.board).to be_a(Board)
    end
  end

  context ".launch_game" do
    before do
      allow(subject).to receive(:ask_piece_position).and_return(true)
      allow(subject).to receive(:ask_new_position).and_return(true)
      allow(Ui).to receive(:board_display)
      allow(Ui).to receive(:victory_message)
    end
    after do
      subject.launch_game
    end
    it "launches a new turn if there's no victory" do
      allow(subject).to receive(:victory?).and_return(false, true)
      expect(subject).to receive(:one_turn)
    end

    it "exits the game in case of victory" do
      allow(subject).to receive(:victory?).and_return(true)
      expect(subject).to receive(:exit_now)
    end
  end

  context ".end_game" do
    before do
      allow(Ui).to receive(:victory_message)
      allow(Ui).to receive(:board_display)
    end

    it "displays a victory message in case of victory" do
      allow(subject).to receive(:victory?).and_return(true)
      expect(Ui).to receive(:victory_message)
      subject.end_game('white')
    end
  end
end
