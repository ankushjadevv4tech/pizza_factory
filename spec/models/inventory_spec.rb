require 'rails_helper'

RSpec.describe Inventory, type: :model do
  let(:inventory) { Inventory.new }

  describe '#show' do
    it 'returns the correct quantity for an ingredient' do
      expect(inventory.show('pizzas', 'Deluxe Veggie')[:quantity]).to eq(10)
    end

    it 'returns an error if the ingredient does not exist' do
      expect(inventory.show('pizzas', 'Non-Existing Pizza')[:error]).to eq('Non-Existing Pizza not found in inventory')
    end
  end

  describe '#restock' do
    it 'restocks a pizza correctly' do
      expect(inventory.restock('pizzas', 'Deluxe Veggie', 5)[:message]).to eq('Deluxe Veggie restocked with 5 items.')
      expect(inventory.show('pizzas', 'Deluxe Veggie')[:quantity]).to eq(15)
    end

    it 'returns an error if quantity to restock is invalid' do
      expect(inventory.restock('pizzas', 'Deluxe Veggie', -5)[:error]).to eq('Quantity to restock must be greater than 0')
    end
  end

  describe '#check_availability' do
    it 'returns a success message if there is enough stock' do
      expect(inventory.check_availability('pizzas', 'Deluxe Veggie', 5)[:message]).to eq('Deluxe Veggie is available in sufficient quantity.')
    end

    it 'returns an error if there is not enough stock' do
      expect(inventory.check_availability('pizzas', 'Deluxe Veggie', 20)[:error]).to eq('Deluxe Veggie is not available in the required quantity.')
    end
  end
end
