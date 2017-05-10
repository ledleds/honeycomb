class Order
  # does this class have more than one responsibility?!
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  EXPRESS_DELIVERY_DISCOUNT = 5
  OVERALL_COST_DISCOUNT = 0.1

  attr_accessor :material, :items, :discount

  def initialize(material)
    self.material = material
    self.items = []
    self.discount = 0
  end

  def add(broadcaster, delivery)
    items << [broadcaster, delivery]
  end

  def subtotal
    items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

  def delivery_discount
    if express_delivery_count >= 2
      self.discount += express_delivery_count * EXPRESS_DELIVERY_DISCOUNT
    end
  end

  def express_delivery_count
    items.count { |item| item[1].name == :express }
  end

  def overall_cost_discount
    if subtotal > 30
      self.discount += percentage_calculator
    end
  end

  def percentage_calculator
    subtotal * OVERALL_COST_DISCOUNT
  end

  def total_cost
    delivery_discount
    overall_cost_discount
    return subtotal - self.discount
  end

  def output
    [].tap do |result|
      result << "Order for #{material.identifier}:"

      result << COLUMNS.map { |name, width| name.to_s.ljust(width) }.join(' | ')
      result << output_separator

      items.each_with_index do |(broadcaster, delivery), index|
        result << [
          broadcaster.name.ljust(COLUMNS[:broadcaster]),
          delivery.name.to_s.ljust(COLUMNS[:delivery]),
          ("$#{delivery.price}").ljust(COLUMNS[:price])
        ].join(' | ')
      end

      result << output_separator
      result << "Total: $#{'%.2f' % total_cost}" # move the rounding?
    end.join("\n")
  end

  private

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end
end
