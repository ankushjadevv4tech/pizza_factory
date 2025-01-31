require 'rails_helper'

RSpec.describe Side, type: :model do
  let(:side) { Side.new('Cold drink', 55) }

  describe '#initialize' do
    it 'initializes with the correct attributes' do
      expect(side.name).to eq('Cold drink')
      expect(side.price).to eq(55)
    end
  end
end