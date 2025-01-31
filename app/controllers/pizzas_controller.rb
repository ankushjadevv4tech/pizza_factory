class PizzasController < ApplicationController
  before_action :set_pizza_store

  def index
    render json: @pizza_store.pizzas
  end

  def add_topping
    pizza = @pizza_store.get_pizza(params[:name])

    if pizza
      topping = Topping.new(topping_params[:name], topping_params[:price].to_i, topping_params[:type])
      if pizza.can_add_topping?(topping)
        pizza.add_topping(topping)
        render json: pizza, status: :ok
      else
        render json: { error: 'Invalid topping for this pizza' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Pizza not found' }, status: :not_found
    end
  end

  private

  def set_pizza_store
    @pizza_store = PizzaStore.new
    @pizza_store.prepopulate
  end

  def topping_params
    params.require(:topping).permit(:name, :price, :type)
  end
end
