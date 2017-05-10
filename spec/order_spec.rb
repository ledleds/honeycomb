require './models/order'

describe Order do
  subject { Order.new(material, discount) }
  let(:material) { double :material }
  let(:discount) { double :discount, delivery_discount: 0, overall_cost_discount: 0, amount: 0}
  let(:standard_delivery) { double :standard_delivery, name: :standard, price: 10 }
  let(:express_delivery) { double :express_delivery, name: :express, price: 20 }

  context 'empty' do
    it 'has a subtotal of 0' do
      expect(subject.subtotal).to eq(0)
    end

    it 'has a total cost of 0' do
      expect(subject.total_cost).to eq(0)
    end

    it 'has an empty items array' do
      expect(subject.items). to eq([])
    end
  end

  context 'adding items' do
    let(:broadcaster_1) {double :broadcaster_1 }

    it 'adds an item to the order' do
      subject.add broadcaster_1, standard_delivery

      expect(subject.items.length).to eq(1)
    end
  end

  # context 'with items' do
  #   let(:broadcaster_1) {double :broadcaster_1 }
  #   let(:broadcaster_2) {double :broadcaster_2 }
  #
  #   before do
  #     subject.add broadcaster_1, standard_delivery
  #     subject.add broadcaster_2, express_delivery
  #   end
  #
  #
  #   it 'returns the total cost of all items' do
  #     expect(subject.subtotal).to eq(30)
  #   end
  #
  #   it 'counts the number of express deliveries' do
  #     expect(subject.express_delivery_count).to eq 1
  #   end
  #
  #
  # end
end
