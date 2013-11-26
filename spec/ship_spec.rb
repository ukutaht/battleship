require 'spec_helper'
describe Ship do
  subject(:ship) { Ship.new('Destroyer', 2) }
  
  describe '#place' do
    it 'updates coordinates when valid' do
      ship.place(['C2', 'D2'])
      ship.coordinates.should eq ['C2', 'D2']
    end

    it 'raises error when invalid' do
      expect{ ship.place(['C2', 'C3', 'C4']) }.to raise_error
    end
  end

  describe '#placed?' do
    it 'returns true when placed' do
      ship.stub(:coordinates).and_return(['C2', 'C3'])

      ship.placed?.should eq true
    end

     it 'returns false when not placed' do
      ship.stub(:coordinates).and_return([])

      ship.placed?.should eq false
    end
  end
end