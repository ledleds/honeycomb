require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'

describe Order do
  subject { Order.new material }
  let(:material) { Material.new 'HON/TEST001/010' }
  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }

  context 'empty' do
    it 'costs nothing' do
      expect(subject.subtotal).to eq(0)
    end

    it 'has a discount amount of zero' do
      expect(subject.discount).to eq(0)
    end
  end

  context 'adding items' do
    let(:broadcaster_1) {double(:broadcaster_1)}

    it 'adds an item to the order' do
      subject.add broadcaster_1, standard_delivery

      expect(subject.items.length).to eq(1)
    end
  end

  context 'with items' do
    before do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')

      subject.add broadcaster_1, standard_delivery
      subject.add broadcaster_2, express_delivery
    end

    it 'returns the total cost of all items' do
      expect(subject.subtotal).to eq(30)
    end

    it 'counts the number of express deliveries' do
      expect(subject.express_delivery_count).to eq 1
    end

    it 'adds amount to discount when two materials are express delivery' do
      broadcaster_3 = Broadcaster.new(3, 'Discovery')

      subject.add broadcaster_3, express_delivery

      subject.delivery_discount
      expect(subject.discount).to eq(10)
    end

    it 'initiates a 10% discount if total cost is over 30' do
      broadcaster_4 = Broadcaster.new(4, 'ITV')

      subject.add broadcaster_4, standard_delivery

      subject.overall_cost_discount
      expect(subject.discount).to eq(4)
    end
  end
end
