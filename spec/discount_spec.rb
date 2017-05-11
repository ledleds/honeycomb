require './models/discount'

describe Discount do
  subject { Discount.new }
  let(:order) { double :order, subtotal: 0, express_delivery_count: 0 }

  context 'to begin' do
    it 'has a discount amount of zero' do
      expect(subject.amount).to eq(0)
    end
  end

  context 'with an express delivery count of 2' do
    it 'adds 10 to amount' do
      allow(order).to receive(:express_delivery_count).and_return(2)
      expect(subject.delivery_discount(order.express_delivery_count)).to eq(10)
    end
  end

  context 'with a subtotal of 50' do
    it 'adds 5 to amount' do
      allow(order).to receive(:subtotal).and_return(50)
      expect(subject.overall_cost_discount(order.subtotal)).to eq(5)
    end
  end
end
