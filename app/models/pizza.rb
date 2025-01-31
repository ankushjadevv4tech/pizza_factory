class Pizza
  attr_accessor :name, :size, :crust, :toppings, :price

  def initialize(name, size, crust)
    @name = name
    @size = size
    @crust = crust
    @toppings = []
    @price = calculate_base_price
  end

  def add_topping(topping)
      @toppings << topping
      update_price
  end

  def calculate_base_price
    base_price = case @size
                 when 'Regular' then price_for_size[:regular][name]
                 when 'Medium' then price_for_size[:medium][name]
                 when 'Large' then price_for_size[:large][name]
                 else 0
                 end
    base_price
  end

  def update_price
    @price = calculate_base_price + @toppings.sum(&:price)
  end

  def price_for_size
    {
      regular: {
        'Deluxe Veggie' => 150,
        'Cheese and corn' => 175,
        'Paneer Tikka' => 160,
        'Non-Veg Supreme' => 190,
        'Chicken Tikka' => 210,
        'Pepper Barbecue Chicken' => 220
      },
      medium: {
        'Deluxe Veggie' => 200,
        'Cheese and corn' => 375,
        'Paneer Tikka' => 290,
        'Non-Veg Supreme' => 325,
        'Chicken Tikka' => 370,
        'Pepper Barbecue Chicken' => 380
      },
      large: {
        'Deluxe Veggie' => 325,
        'Cheese and corn' => 475,
        'Paneer Tikka' => 340,
        'Non-Veg Supreme' => 425,
        'Chicken Tikka' => 500,
        'Pepper Barbecue Chicken' => 525
      }
    }
  end

  def can_add_topping?(topping)
    if name.include?("Veg") && topping.non_veg?
      return false
    elsif name.include?("Non-Veg") && topping.veg?
      return false
    end
    true
  end
end
