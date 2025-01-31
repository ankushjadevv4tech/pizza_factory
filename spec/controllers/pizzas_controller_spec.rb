require 'rails_helper'

RSpec.describe PizzasController, type: :controller do
  let(:user) { User.new('admin', 'password123') }
  let(:token) { AuthenticationHelper.encode({ username: user.username }) }

  before do
    request.headers['Authorization'] = token
    @pizza_store = PizzaStore.new
    @pizza_store.prepopulate
  end

  describe "GET #index" do
    it "returns a list of pizzas" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #add_topping" do
    context "when pizza exists" do
      it "adds a valid topping to the pizza" do
        pizza = @pizza_store.pizzas.first
        post :add_topping, params: { name: pizza.name, topping: { name: 'Capsicum', price: 25, type: 'veg' } }
        
        response_body = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(response_body['toppings'].map { |t| t['name'] }).to include('Capsicum')
      end

      it "returns an error if topping is invalid" do
        pizza = @pizza_store.pizzas.last  # Fetch a non-veg pizza
        post :add_topping, params: { name: pizza.name, topping: { name: 'Mushroom', price: 30, type: 'veg' } }
        
        response_body = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['error']).to eq('Invalid topping for this pizza')
      end
    end

    context "when pizza does not exist" do
      it "returns a not found error" do
        post :add_topping, params: { name: 'Non-Existent Pizza', topping: { name: 'Capsicum', price: 25, type: 'veg' } }

        response_body = JSON.parse(response.body)
        expect(response).to have_http_status(:not_found)
        expect(response_body['error']).to eq('Pizza not found')
      end
    end
  end
end
