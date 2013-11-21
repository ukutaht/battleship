require 'spec_helper'

describe CoordinateRange do
  describe '#get' do
    it 'returns correct indices when horizontal' do
      CoordinateRange.get("A1", "A6").should eq ["A1", "A2", "A3", "A4", "A5", "A6"]
    end

    it 'returns correct indices when horizontal' do
      CoordinateRange.get("A1", "D1").should eq ["A1", "B1", "C1", "D1"]
    end

    it 'raises error for for unvalid range' do
      expect { CoordinateRange.get("A3", "B9") }.to raise_error
    end
  end
end
