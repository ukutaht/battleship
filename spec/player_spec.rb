require 'spec_helper'
describe Player do 
  describe 'place_ship' do
     it 'marks ship as placed' do
      Ship.any_instance.should_receive(:place).with(['C2', 'C3'])

      subject.place_ship('Destroyer', ['C2', 'C3'])
    end

    it 'marks ship on the board' do
      subject.board.should_receive(:mark_ship!).with(['C2', 'C3'])

      subject.place_ship('Destroyer', ['C2', 'C3'])
    end

    it 'removes ship from fleet' do
      expect{ subject.place_ship('Destroyer', ['C2', 'C3']) }
      .to change{ subject.fleet.size }.by(-1)
    end
  end
end