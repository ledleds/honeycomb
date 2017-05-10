require './models/order'

describe Order do
  subject { Order.new material }
  let(:material) { double :material }
  let(:standard_delivery) { double :standard_delivery, name: :standard, price: 10 }
  let(:express_delivery) { double :express_delivery, name: :express, price: 20 }

  context 'empty' do
    it 'costs nothing' do
      expect(subject.subtotal).to eq(0)
    end

    it 'has a discount amount of zero' do
      expect(subject.discount).to eq(0)
    end

    it 'has an empty items array' do
      expect(subject.items). to eq([])
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
    let(:broadcaster_1) {double(:broadcaster_1)}
    let(:broadcaster_2) {double(:broadcaster_2)}
    let(:broadcaster_3) {double(:broadcaster_3)}
    let(:broadcaster_4) {double(:broadcaster_4)}
    let(:broadcaster_5) {double(:broadcaster_5)}
    let(:broadcaster_6) {double(:broadcaster_6)}

    before do
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
      subject.add broadcaster_3, express_delivery

      subject.delivery_discount

      expect(subject.discount).to eq(10)
    end

    it 'initiates a 10% discount if total cost is over 30' do
      subject.add broadcaster_4, standard_delivery

      subject.overall_cost_discount

      expect(subject.discount).to eq(4)
    end

    it 'returns the total cost of all items after discount' do
      subject.add broadcaster_5, standard_delivery
      subject.add broadcaster_6, standard_delivery

      expect(subject.total_cost).to eq(45)
    end
  end
end
