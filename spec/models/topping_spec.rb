require 'rails_helper'

RSpec.describe Topping, type: :model do
  let(:veg_topping) { Topping.new('Black Olive', 20, 'veg') }
  let(:non_veg_topping) { Topping.new('Chicken Tikka', 35, 'non-veg') }

  describe '#initialize' do
    it 'initializes with the correct attributes' do
      expect(veg_topping.name).to eq('Black Olive')
      expect(veg_topping.price).to eq(20)
      expect(veg_topping.type).to eq('veg')
    end
  end

  describe '#veg?' do
    it 'returns true for veg toppings' do
      expect(veg_topping.veg?).to be(true)
    end

    it 'returns false for non-veg toppings' do
      expect(non_veg_topping.veg?).to be(false)
    end
  end

  describe '#non_veg?' do
    it 'returns true for non-veg toppings' do
      expect(non_veg_topping.non_veg?).to be(true)
    end

    it 'returns false for veg toppings' do
      expect(veg_topping.non_veg?).to be(false)
    end
  end
end
