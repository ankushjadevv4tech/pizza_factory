require 'rails_helper'

RSpec.describe InventoryController, type: :controller do
  let(:inventory) { Inventory.new }
  let(:user) { User.new('admin', 'password123') }
  let(:token) { AuthenticationHelper.encode({ username: user.username }) }

  before do
    request.headers['Authorization'] = token
  end
  
  describe 'GET #index' do
    it 'returns all inventory items' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include("pizzas", "crusts", "toppings")
    end
  end

  describe 'GET #show' do
    it 'returns the stock of a specific ingredient (pizza)' do
      get :show, params: { type: 'pizzas', name: 'Deluxe Veggie' }
      expect(response).to have_http_status(:ok)
      response_body = JSON.parse(response.body)
      expect(response_body['name']).to eq('Deluxe Veggie')
      expect(response_body['quantity']).to be_a(Integer)
    end

    it 'returns an error if the ingredient is not found' do
      get :show, params: { type: 'pizzas', name: 'Non-Existing Pizza' }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Non-Existing Pizza not found in inventory')
    end
  end

  describe 'POST #restock' do
    it 'restocks an ingredient with a valid quantity' do
      post :restock, params: { type: 'pizzas', name: 'Deluxe Veggie', quantity: 5 }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('Deluxe Veggie restocked with 5 items.')
    end

    it 'returns an error if the quantity to restock is invalid (<= 0)' do
      post :restock, params: { type: 'pizzas', name: 'Deluxe Veggie', quantity: -5 }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['error']).to eq('Quantity to restock must be greater than 0')
    end
  end

  describe 'POST #check_availability' do
    it 'checks if an ingredient is available in sufficient quantity' do
      post :check_availability, params: { type: 'toppings', name: 'Mushroom', quantity: 5 }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('Mushroom is available in sufficient quantity.')
    end

    it 'returns an error if the ingredient is not available in the required quantity' do
      post :check_availability, params: { type: 'toppings', name: 'Mushroom', quantity: 100 }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['error']).to eq('Mushroom is not available in the required quantity.')
    end
  end
end
