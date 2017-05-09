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
      expect(subject.total_cost).to eq(0)
    end
  end

  context 'adding items' do
    it 'adds an item to the order' do
      broadcaster_1 = Broadcaster.new(1, 'Discovery')

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
      expect(subject.total_cost).to eq(30)
    end

    it 'counts the number of express deliveries' do
      expect(subject.express_delivery_count).to eq 1
    end

  end
end
