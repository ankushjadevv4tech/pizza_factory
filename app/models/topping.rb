class Topping
  attr_accessor :name, :price, :type

  def initialize(name, price, type)
    @name = name
    @price = price
    @type = type # can be 'veg' or 'non-veg'
  end

  def veg?
    @type == 'veg'
  end

  def non_veg?
    @type == 'non-veg'
  end
end
