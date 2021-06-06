require './lib/computer'

describe Computer do
  let(:player) { Computer.new('FooBot', :white) }

  describe '#initialize' do
    context 'When a new player is created' do
      it 'a name is assigned to it' do
        expect(player.name).to eql('FooBot')
      end

      it 'a color is assigned to it' do
        expect(player.color).to eql(:white)
      end

      it 'it starts with 21 checkers' do
        expect(player.checkers).to eql(21)
      end
    end
  end
end
