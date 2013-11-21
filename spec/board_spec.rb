require 'spec_helper'

describe Board do

  describe 'initialize' do
    subject(:board) { Board.new }

    it 'initializes with cells' do
      board[1][2].should be_a Cell
    end

  end

end
