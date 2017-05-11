class Discount

  EXPRESS_DELIVERY_DISCOUNT = 5
  DELIVERY_DISCOUNT_MIN = 2
  COST_DISCOUNT_MIN = 30
  OVERALL_COST_DISCOUNT = 0.1

  attr_accessor :amount

  def initialize
    self.amount = 0
  end

  def delivery_discount(express_delivery_count)
    if express_delivery_count >= DELIVERY_DISCOUNT_MIN
      self.amount += express_delivery_count * EXPRESS_DELIVERY_DISCOUNT
    end
    return self.amount
  end

  def overall_cost_discount(subtotal)
    if subtotal > COST_DISCOUNT_MIN
      self.amount += subtotal * OVERALL_COST_DISCOUNT
    end
  end
end
