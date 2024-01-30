require_relative "../lib/game.rb"
one = "O"
two = "X"
describe Game do
  describe "#player_turn" do
    subject(:game) { described_class.new }

    before do
      allow(game).to receive(:check_win).and_return(false)
    end

    context "when a player makes a valid move" do
      it "goes on the last row" do
        board_after = [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, one, nil, nil, nil],
        ]
        player1 = game.instance_variable_get(:@player1)
        game.player_turn(player1, 3)
        expect(game.instance_variable_get(:@board)).to eq(board_after)
      end
    end

    context "when a player makes a valid move in a column which is already chosen" do
      it "updates the chosen column correctly" do
        board_after = [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, one, nil, nil, nil],
          [nil, nil, nil, one, two, nil, nil],
        ]
        player1 = game.instance_variable_get(:@player1)
        player2 = game.instance_variable_get(:@player2)
        game.player_turn(player1, 3)
        game.player_turn(player2, 4)
        game.player_turn(player1, 3)
        expect(game.instance_variable_get(:@board)).to eq(board_after)
      end
    end
  end

  describe "#check_win" do
    subject(:game) { described_class.new }
    before do
      allow(game).to receive(:ask_player).and_return(false)
    end
    context "when a player makes the final move" do
      it "tells u won, horizontally" do
        game.instance_variable_set(:@board,
        [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, two, two, two, nil, nil, nil],
          [nil, one, one, one, one, nil, nil]
        ])
        
        expect(game.horizontal_win?).to eq(true)
        
      end
    end


    context "when a player makes the final move" do
      it "tells u won, vertically" do
        game.instance_variable_set(:@board,
        [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, one, nil, nil, nil, nil, nil],
          [nil, one, two, nil, nil, nil, nil],
          [nil, one, two, two, nil, nil, nil],
          [nil, one, two, two, one, nil, nil]
        ])
        
        expect(game.vertical_win?).to eq(true)
        
      end
    end

    context "when a player makes the final move" do
      it "tells u won, diagonally" do
        game.instance_variable_set(:@board,
        [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, one, nil, nil],
          [nil, one, two, one, two, nil, nil],
          [nil, one, one, two, two, nil, nil],
          [nil, one, two, two, one, nil, nil]
        ])
        
        expect(game.diagonal_win?).to eq(true)
        
      end
    end
  end
end






