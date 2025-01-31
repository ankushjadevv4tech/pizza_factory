class Order
  attr_accessor :pizzas, :sides, :total_amount, :status

  def initialize
    @pizzas = []
    @sides = []
    @total_amount = 0
    @status = 'Pending'
  end

  def add_pizza(pizza)
    @pizzas << pizza
    update_total
  end

  def add_side(side)
    @sides << side
    update_total
  end

  def update_total
    @total_amount = @pizzas.sum(&:price) + @sides.sum(&:price)
  end

  def place_order
    if status == 'Pending'
      @status = 'Confirmed'
      true
    else
      false
    end
  end
end
