class PizzaStore
  attr_accessor :pizzas, :toppings, :sides

  def initialize
    @pizzas = []
    @toppings = []
    @sides = []
  end

  def prepopulate
    pizza1 = Pizza.new('Deluxe Veggie', 'Medium', 'Hand Tossed')
    pizza1.add_topping(Topping.new('Black Olive', 20, 'veg'))
    pizza1.add_topping(Topping.new('Mushroom', 30, 'veg'))
    @pizzas << pizza1

    pizza2 = Pizza.new('Non-Veg Supreme', 'Large', 'Cheese Burst')
    pizza2.add_topping(Topping.new('Grilled Chicken', 40, 'non-veg'))
    pizza2.add_topping(Topping.new('Barbeque Chicken', 45, 'non-veg'))
    @pizzas << pizza2

    @toppings = [
      Topping.new('Black Olive', 20, 'veg'),
      Topping.new('Capsicum', 25, 'veg'),
      Topping.new('Mushroom', 30, 'veg'),
      Topping.new('Chicken Tikka', 35, 'non-veg'),
      Topping.new('Grilled Chicken', 40, 'non-veg'),
      Topping.new('Barbeque Chicken', 45, 'non-veg')
    ]

    @sides = [
      Side.new('Cold drink', 55),
      Side.new('Mousse cake', 90)
    ]
  end

  def add_pizza(pizza)
    @pizzas << pizza
  end

  def add_topping(topping)
    @toppings << topping
  end

  def add_side(side)
    @sides << side
  end

  def get_pizza(name)
    @pizzas.find { |pizza| pizza.name == name }
  end
end
