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

  describe '#place_ship!' do
    
    it 'updates ships attribute' do
      Cell.any_instance.should_receive(:mark_ship!).exactly(5).times
      
      board.place_ship!(ship, coordinates)
      board.ships.should include(ship)
    end

    it 'errors with invalid coordinates' do
      coordinates = ['A1', 'A2', 'A3', 'A4', 'A5', 'A6']

      expect { board.place_ship!(ship, coordinates) }.to raise_error
    end
  end

  describe '#hide ships' do
    it 'hides ships' do
      board.place_ship!(ship, coordinates)

      board.hide_ships[0][0].should_not eq Cell::Ship
    end
  end

  describe '#fire' do
    it 'marks cell as a hit' do
      board.place_ship!(ship, coordinates)

      board.fire!("A2")
      board.cell_at('A2').should be_hit
    end

    it 'updates @hits_at' do
      board.place_ship!(ship, coordinates)
      board.fire!("A2")

      board.hits_at.should include("A2")
    end
  end

  describe "replace sunken ships" do
    it 'replaces sunken ships' do
      board.place_ship!(ship, coordinates)
      board.fire!("A1")
      board.fire!("A2")
      board.fire!("A3")
      board.fire!("A4")
      board.fire!("A5")

      board.replace_sunken_ships.cell_at("A1").should be_sunken      

    end
  end

end










