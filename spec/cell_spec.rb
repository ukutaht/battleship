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

  describe '#mark_ship' do
    it 'marks ship when valid' do
      Cell.new.mark_ship!.should eq Cell::Ship
    end

    it 'errors when invalid' do
      cell = Cell.new
      cell.miss!
      expect { cell.place_ship! }.to raise_error
    end
  end

  describe '#hide_ship' do
    it "hides ship" do
      c = Cell.new
      c.mark_ship!
      c.hide_ship.should eq Cell::Empty
    end
  end

end
