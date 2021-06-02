# frozen_string_literal: true

require './lib/gamestate'

describe Gamestate do
  let(:game) { Gamestate.new(true) }
  let(:grid) { game.grid }

  describe '#initialize' do
    context 'When a new game is created' do
      it 'generates a new grid array' do
        expect(grid).to be_an(Array)
      end

      it 'gird array has 7 nested arrays' do
        expect(grid.size).to eql(7)
      end

      it 'sets player 1 decided by boolean if computer or human' do
        expect(game.player1).to be_a(Player)
      end

      it 'sets player 2 decided by boolean if computer or human' do
        expect(game.player2).to be_a(Computer)
      end
    end
  end

  describe '#place_checker' do
    context 'when invalid column is selected' do
      it 'rejects input and resends input request' do
        expect(game.place_checker(grid[42])).to eql(:retry)
      end
    end

    context 'when a valid column is selected' do
      subject { grid[3] }
      let(:place_checker) { game.place_checker(grid[3]) }

      it 'correct checker falls to the bottom(start) of the column' do
        place_checker
        expect(subject).to eql([:white])
      end

      it 'correct checker is placed over an existing checker' do
        2.times { game.place_checker(subject) }
        expect(subject).to eql(%i[white black])
      end

      it 'stops adding checkers if column is full, request retry' do
        6.times { game.place_checker(subject) }
        expect(game.place_checker(subject)).to eql(:retry)
      end
    end
  end
end
