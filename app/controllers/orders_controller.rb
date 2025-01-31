class OrdersController < ApplicationController
  def create
    order = Order.new
  
    build_pizzas(order)
    build_sides(order)
  
    if order.place_order
      render json: { total_amount: order.total_amount, status: order.status }, status: :created
    else
      render json: { error: 'Order could not be placed' }, status: :unprocessable_entity
    end
  end
  
  private
  
  def build_pizzas(order)
    pizzas_params = params[:order][:pizzas]
    
    pizzas_params.each do |pizza_param|
      pizza = Pizza.new(pizza_param[:name], pizza_param[:size], pizza_param[:crust])
      add_toppings_to_pizza(pizza, pizza_param[:toppings])
      order.add_pizza(pizza)
    end
  end
  
  def add_toppings_to_pizza(pizza, toppings_params)
    toppings_params.each do |topping_param|
      topping = Topping.new(topping_param[:name], topping_param[:price].to_i, topping_param[:type])
      pizza.add_topping(topping)
    end
  end
  
  def build_sides(order)
    sides_params = params[:order][:sides]
  
    sides_params.each do |side_param|
      side = Side.new(side_param[:name], side_param[:price].to_i)
      order.add_side(side)
    end
  end
end
