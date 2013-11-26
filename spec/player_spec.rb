require 'spec_helper'
describe Player do 
  let(:coordinates) {  ['A1', 'A2', 'A3', 'A4', 'A5'] }
  let(:ship) { subject.fleet.first }

  describe 'place_ship' do
     it 'marks ship as placed' do
      ship.should_receive(:place).with(coordinates)

      subject.place_ship(ship, coordinates)
    end

    it 'marks ship on the board' do
      subject.board.should_receive(:mark_ship!).with(coordinates)

      subject.place_ship(ship, coordinates)
    end

    it 'removes ship from fleet' do
      expect{ subject.place_ship(ship, coordinates) }
      .to change{ subject.fleet.size }.by(-1)
    end
  end
end
