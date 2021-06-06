# frozen_string_literal: true

require './lib/gamestate'

describe Gamestate do
  let(:game) { Gamestate.new(true, false) }
  let(:grid) { game.grid }
  p 'inside main describe'

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

      it 'correct checker is placed over an existing checker' do
        2.times { game.place_checker(subject) }
        expect(subject).to eql(%i[white black])
      end

      it 'stops adding checkers if column is full, requests retry' do
        6.times { game.place_checker(subject) }
        expect(game.place_checker(subject)).to eql(:retry) #placehodlr
      end
    end
  end

  let(:player1) { game.player1 }
  let(:player2) { game.player2 }

  describe '#checker_checker' do
    context 'When both players have zero checkers' do
      it 'ends the game, asks for another game.' do
        player1.checkers = 0
        player2.checkers = 0
        expect(game.checker_checker).to (be true)
      end
    end
  end

  describe '#checker_win' do
    context 'after a checker is placed the Grid is checked for ConnectFour' do

      xit 'returns correct player.wins if 4 horizontal checkers are present' do
        2.times { game.place_checker(grid[0]) }
        2.times { game.place_checker(grid[1]) }
        2.times { game.place_checker(grid[2]) }
        1.times { game.place_checker(grid[3]) }
        expect(game.checker_win(grid[3])).to eql(player1)
      end

      xit 'returns player if 4 vertical checkers are present' do
        expect(game.checker_win).to eql(player2)
      end

      xit 'returns player if 4 descending diaginal checkers are present' do
        expect(game.checker_win).to eql(player1)
      end

      xit 'returns player if 4 ascending diaginal checkers are present' do
        expect(game.checker_win).to eql(player2)
      end

      xit 'if no win conditions are met no action is taken' do
        expect(game.checker_win(grid[0])).to (be nil)
      end
    end
  end
end
