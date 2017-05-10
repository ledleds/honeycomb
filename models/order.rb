class Order

  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  attr_accessor :material, :items, :material, :order, :discount

  def initialize(material, discount)
    self.material = material
    self.discount = discount
    self.items = []
    self.order = []
  end

  def add(broadcaster, delivery)
    items << [broadcaster, delivery]
  end

  def subtotal
    items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

  def total_cost
    discount.delivery_discount(express_delivery_count)
    discount.overall_cost_discount(subtotal)

    return subtotal - self.discount.amount
  end

  def output
    order.tap do |result|
      result << "Order for #{material.identifier}:"
      columns
      result << output_separator
      justify
      result << output_separator
      result << "Total: $#{'%.2f' % total_cost}" # move the rounding?
    end.join("\n")
  end

  def justify
    items.each_with_index do |(broadcaster, delivery), index|
      order << [
        broadcaster.name.ljust(COLUMNS[:broadcaster]),
        delivery.name.to_s.ljust(COLUMNS[:delivery]),
        ("$#{delivery.price}").ljust(COLUMNS[:price])
      ].join(' | ')
    end
  end

  private

  def express_delivery_count
    items.count { |item| item[1].name == :express }
  end

  def columns
    order << COLUMNS.map { |name, width| name.to_s.ljust(width) }.join(' | ')
  end

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end
end
