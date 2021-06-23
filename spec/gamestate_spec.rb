# frozen_string_literal: true

require './lib/gamestate'

describe Gamestate do
  let(:game) { Gamestate.new(true, false) }
  let(:grid) { game.grid }

  describe '#initialize' do
    context 'When a new game is created' do
      it 'generates a new grid array' do
        expect(grid).to be_an(Array)
      end

      it 'gird array has 7 empty nested arrays' do
        expect(grid.size).to eql(7)
      end

      it 'sets player 1 decided by boolean if computer or *human' do
        expect(game.player1).to be_a(Player)
      end

      it 'sets player 2 decided by boolean if *computer or human' do
        expect(game.player2).to be_a(Computer)
      end
    end
  end

  describe '#place_checker' do
    context 'when a valid column is selected' do
      subject { grid[3] }

      it 'correct checker falls to the bottom(start) of the column' do
        game.place_checker(subject)
        expect(subject).to eql([:white])
      end

      it 'stops adding checkers if column is full, requests retry' do
        6.times { game.place_checker(subject) }
        expect(game.place_checker(subject)).to eql(:retry) # placehodlr
      end
    end
  end


  describe '#checker_checker' do
    context 'When both players have zero checkers' do
      it 'ends the game, asks for another game.' do
        game.player1.checkers = 0
        game.player2.checkers = 0
        expect(game.checker_checker).to(be true)
      end
    end
  end

  describe '#four_in_a_row?' do
    context 'when passed an array' do
      it 'returns true if 4 of the same object are consecutive' do
        expect(game.four_in_a_row?(%i[orange banana banana banana banana orange])).to(be true)
      end

      it 'returns false if array is empty' do
        expect(game.four_in_a_row?([])).to (be false)
      end

      it 'returns false if 4 consecutive nil objects are present' do
        expect(game.four_in_a_row?([nil, nil, nil, nil])).to(be false)
      end

      it 'returns false if less than 4 objects are present' do
        expect(game.four_in_a_row?(%i[apples oranges bananas])).to(be false)
      end

      it 'returns false if 4 objects are present, but are different' do
        expect(game.four_in_a_row?(%i[apples oranges bananas potatos])).to(be false)
      end
    end
  end

  describe '#checker_win' do
    context 'after a checker is placed the Grid is checked for ConnectFour' do
      it 'if 4 vertical checkers are present returns true' do
        grid[3] = %i[black black black black]
        expect(game.checker_win(3)).to(be true)
      end

      it 'returns true if 4 horizontal checkers are present' do
        grid[1] = %i[white white]
        grid[2] = %i[black white]
        grid[3] = %i[black white]
        grid[4] = %i[black white]
        expect(game.checker_win(3)).to(be true)
      end

      it 'if 4 descending diaginal checkers are present returns true' do
        grid[0] = [nil, nil,nil,:black]
        grid[1] = [nil, nil, :black]
        grid[2] = [nil, :black]
        grid[3] = [:black]
        expect(game.checker_win(2)).to(be true)
      end

      it 'if 4 ascending diaginal checkers are present returns true' do
        grid[0] = [:black]
        grid[1] = [nil, :black]
        grid[2] = [nil, nil, :black]
        grid[3] = [nil, nil, nil,:black]
        expect(game.checker_win(1)).to(be true)
      end

      it 'if no win conditions are met retruns false' do
        grid[5] = %i[apples bannanas oranges grapes]
        expect(game.checker_win(5)).to(be false)
      end
    end
  end
end
