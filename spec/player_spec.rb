# frozen_string_literal: true

require './lib/player'

describe Player do
  let(:player) { Player.new('Foo', :black) }

  describe '#initialize' do
    context 'When a new player is created' do
      it 'a name is assigned to it' do
        expect(player.name).to eql('Foo')
      end

      it 'a color is assigned to it' do
        expect(player.color).to eql(:black)
      end

      it 'it starts with 21 checkers' do
        expect(player.checkers).to eql(21)
      end
    end
  end
end
