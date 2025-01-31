require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { Order.new }
  let(:pizza) { Pizza.new('Deluxe Veggie', 'Medium', 'Hand Tossed') }
  let(:side) { Side.new('Cold drink', 55) }
  let(:veg_topping) { Topping.new('Black Olive', 20, 'veg') }

  describe '#add_pizza' do
    it 'adds a pizza to the order' do
      order.add_pizza(pizza)
      expect(order.pizzas).to include(pizza)
    end
  end

  describe '#add_side' do
    it 'adds a side to the order' do
      order.add_side(side)
      expect(order.sides).to include(side)
    end
  end

  describe '#total_amount' do
    it 'calculates the total amount correctly' do
      pizza.add_topping(veg_topping)
      order.add_pizza(pizza)
      order.add_side(side)
      expect(order.total_amount).to eq(275)  # 220 pizza price + 55 side
    end
  end

  describe '#place_order' do
    it 'places the order successfully if the status is "Pending"' do
      expect(order.place_order).to be(true)
      expect(order.status).to eq('Confirmed')
    end

    it 'does not allow placing the order again if the status is not "Pending"' do
      order.place_order
      expect(order.place_order).to be(false)
    end
  end
end
