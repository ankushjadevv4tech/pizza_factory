class Inventory
  attr_accessor :pizzas, :crusts, :toppings, :sides

  def initialize
    @pizzas = {
      'Deluxe Veggie' => 10,
      'Cheese and corn' => 8,
      'Paneer Tikka' => 12,
      'Non-Veg Supreme' => 5,
      'Chicken Tikka' => 7,
      'Pepper Barbecue Chicken' => 6
    }

    @crusts = {
      'Hand Tossed' => 50,
      'Wheat Thin Crust' => 40,
      'Cheese Burst' => 30,
      'Fresh Pan Pizza' => 25
    }

    @toppings = {
      'Black Olive' => 50,
      'Capsicum' => 45,
      'Paneer' => 30,
      'Mushroom' => 40,
      'Fresh Tomato' => 60,
      'Chicken Tikka' => 25,
      'Barbeque Chicken' => 20,
      'Grilled Chicken' => 15,
      'Extra Cheese' => 35
    }

    @sides = {
      'Cold Drink' => 50,
      'Mousse Cake' => 30
    }
  end

  def show(type, name)
    if type == 'pizzas' && pizzas.key?(name)
      { name: name, quantity: pizzas[name] }
    elsif type == 'crusts' && crusts.key?(name)
      { name: name, quantity: crusts[name] }
    elsif type == 'toppings' && toppings.key?(name)
      { name: name, quantity: toppings[name] }
    elsif type == 'sides' && sides.key?(name)
      { name: name, quantity: sides[name] }
    else
      { error: "#{name} not found in inventory" }
    end
  end

  def restock(type, name, quantity)
    return { error: 'Quantity to restock must be greater than 0' } if quantity <= 0

    if type == 'pizzas' && pizzas.key?(name)
      pizzas[name] += quantity
      { message: "#{name} restocked with #{quantity} items." }
    elsif type == 'crusts' && crusts.key?(name)
      crusts[name] += quantity
      { message: "#{name} restocked with #{quantity} items." }
    elsif type == 'toppings' && toppings.key?(name)
      toppings[name] += quantity
      { message: "#{name} restocked with #{quantity} items." }
    elsif type == 'sides' && sides.key?(name)
      sides[name] += quantity
      { message: "#{name} restocked with #{quantity} items." }
    else
      { error: "#{name} not found in inventory" }
    end
  end

  def check_availability(type, name, quantity)
    if type == 'pizzas' && pizzas.key?(name)
      pizzas[name] >= quantity ? { message: "#{name} is available in sufficient quantity." } : { error: "#{name} is not available in the required quantity." }
    elsif type == 'crusts' && crusts.key?(name)
      crusts[name] >= quantity ? { message: "#{name} is available in sufficient quantity." } : { error: "#{name} is not available in the required quantity." }
    elsif type == 'toppings' && toppings.key?(name)
      toppings[name] >= quantity ? { message: "#{name} is available in sufficient quantity." } : { error: "#{name} is not available in the required quantity." }
    elsif type == 'sides' && sides.key?(name)
      sides[name] >= quantity ? { message: "#{name} is available in sufficient quantity." } : { error: "#{name} is not available in the required quantity." }
    else
      { error: "#{name} not found in inventory" }
    end
  end
end
