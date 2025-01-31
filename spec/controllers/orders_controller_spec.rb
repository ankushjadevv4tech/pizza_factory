require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { User.new('admin','password123') }
  let(:token) { AuthenticationHelper.encode({ username: user.username }) }

  before do
    request.headers['Authorization'] = token
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        order: {
          pizzas: [
            {
              name: 'Deluxe Veggie',
              size: 'Medium',
              crust: 'Hand Tossed',
              toppings: [
                { name: 'Black Olive', price: 20, type: 'veg' },
                { name: 'Mushroom', price: 30, type: 'veg' }
              ]
            }
          ],
          sides: [
            { name: 'Cold drink', price: 55 }
          ]
        }
      }
    end

    it 'creates a new order and returns the correct total amount' do
      post :create, params: valid_params

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['total_amount']).to eq(305)
      expect(JSON.parse(response.body)['status']).to eq('Confirmed')
    end

    it 'returns an error if the order cannot be placed' do
      allow_any_instance_of(Order).to receive(:place_order).and_return(false)

      post :create, params: valid_params

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['error']).to eq('Order could not be placed')
    end
  end
end
