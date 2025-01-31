require 'rails_helper'

RSpec.describe Pizza, type: :model do
  let(:pizza) { Pizza.new('Deluxe Veggie', 'Medium', 'Hand Tossed') }
  let(:veg_topping) { Topping.new('Black Olive', 20, 'veg') }
  let(:non_veg_topping) { Topping.new('Chicken Tikka', 35, 'non-veg') }

  describe '#initialize' do
    it 'initializes with the correct base price for medium size' do
      expect(pizza.price).to eq(200)
    end
  end

  describe '#add_topping' do
    it 'adds a topping to the pizza' do
      pizza.add_topping(veg_topping)
      expect(pizza.toppings).to include(veg_topping)
    end
  end

  describe '#price' do
    it 'calculates the correct price after adding toppings' do
      pizza.add_topping(veg_topping)
      expect(pizza.price).to eq(220)  # 200 base price + 20 for topping
    end
  end
end
