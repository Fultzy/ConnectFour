
require './lib/gamestate'

describe Gamestate do
  let(:game) { Gamestate.new(true) }

  describe '#initialize' do
    context 'When a new game is created' do
      it 'generates a new grid array' do
        expect(game.grid).to be_an(Array)
      end

      it 'gird array has 7 nested arrays' do
        expect(game.grid.size).to eql(7)
      end

      it 'the nested arrays hold 6 empty values' do
        expect(game.grid[1].size).to eql(6)
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

    context 'when a checker is placed within a grid column' do
      xit 'selects the correct color checker to use' do
        expect(game.place_checker(grid[3])).to eql(grid[3[0]] = :black)
      end

      xit 'checker falls to the bottom(start) of the column' do
        expect(game.place_checker(game.grid[1])).to not_be(game.grid[1].empty?)
      end


      xit 'checker is placed over an existing marker in the column' do
        expect(game.place_checker(into a slot)).to be(show a checker ontop another)
      end
    end
  end

end
