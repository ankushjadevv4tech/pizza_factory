class InventoryController < ApplicationController
  before_action :set_inventory

  def index
    render json: {
      pizzas: @inventory.pizzas,
      crusts: @inventory.crusts,
      toppings: @inventory.toppings,
      sides: @inventory.sides
    }
  end

  def show
    result = @inventory.show(params[:type], params[:name])
    if result[:error]
      render json: result, status: :not_found
    else
      render json: result
    end
  end

  def restock
    result = @inventory.restock(params[:type], params[:name], params[:quantity].to_i)
    if result[:error]
      render json: result, status: :unprocessable_entity
    else
      render json: result
    end
  end

  def check_availability
    result = @inventory.check_availability(params[:type], params[:name], params[:quantity].to_i)
    if result[:error]
      render json: result, status: :unprocessable_entity
    else
      render json: result
    end
  end

  private

  def set_inventory
    @inventory = Inventory.new
  end
end
