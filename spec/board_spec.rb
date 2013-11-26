require 'spec_helper'

describe Board do

  let(:board) { Board.new }
  let(:ship) { Ship.new("Aircraft Carrier", 5) }
  let(:coordinates) {  ['A1', 'A2', 'A3', 'A4', 'A5'] }

  describe 'initialize' do

    it 'initializes with cells' do
      board[1][2].should be_a Cell
    end

  end

  describe '#mark_ship!' do
    
    it 'errors when already marked' do
      coordinates = ['A1', 'A2', 'A3', 'A4', 'A5']
      board.mark_ship!(coordinates)      

      expect { board.mark_ship!(['A3']) }.to raise_error
    end
  end

  describe '#hide ships' do
    it 'hides ships' do
      board.mark_ship!(coordinates)

      board.hide_ships[0][0].should_not eq Cell::Ship
    end
  end

  describe '#fire' do
    it 'marks cell as a hit' do
      board.mark_ship!(coordinates)

      board.fire!("A2")
      board.cell_at('A2').should be_hit
    end

    it 'updates @hits_at' do
      board.mark_ship!(coordinates)
      board.fire!("A2")

      board.hits_at.should include("A2")
    end
  end

  describe "replace sunken ships" do
    it 'replaces sunken ships' do
      ship.coordinates = coordinates
      board.mark_ship!(coordinates)
      board.fire!("A1"); board.fire!("A2"); board.fire!("A3"); board.fire!("A4"); board.fire!("A5")

      board.replace_sunken_ships([ship]).cell_at("A1").should be_sunken      

    end
  end

end










