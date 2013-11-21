require 'spec_helper'

describe Cell do
  it 'defaults to empty' do
    Cell.new.should be_empty
  end

  it 'aliases ship to content' do
    c = Cell.new
    c.ship = "Whatever"
    c.ship.should eq "Whatever"
  end

  describe '#place_ship' do
    it 'places ship when valid' do
      Cell.new.place_ship!.should eq Ship
    end

    it 'errors when invalid' do
      expect { Cell.new(Miss).place_ship! }.to raise_error
    end
  end

  describe '#hide_ship' do
    it "hides ship" do
      c = Cell.new
      c.place_ship!
      c.hide_ship.should eq Empty
    end
  end

end
