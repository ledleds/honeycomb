require './models/broadcaster'
require './models/delivery'
require './models/discount'
require './models/material'
require './models/order'

describe Order do
  subject { Order.new(material, discount) }
    let(:discount) { Discount.new }
    let(:material) { Material.new 'HON/TEST001/010' }
    let(:standard_delivery) { Delivery.new(:standard, 10) }
    let(:express_delivery) { Delivery.new(:express, 20) }


    context 'empty' do
      it 'is instantiated with a material' do
        expect(subject.material.identifier).to eq('HON/TEST001/010')
      end
    end

    context 'with items' do
      let(:broadcaster_1) {double :broadcaster_1 }
      let(:broadcaster_2) {double :broadcaster_2 }
      let(:broadcaster_3) {double :broadcaster_3 }
      let(:broadcaster_4) {double :broadcaster_4 }
      let(:broadcaster_5) {double :broadcaster_5 }
      let(:broadcaster_6) {double :broadcaster_6 }
      # these need to be real

      before do
        subject.add broadcaster_1, standard_delivery
        subject.add broadcaster_2, express_delivery
      end

      it 'adds amount to discount when two materials are express delivery' do
        subject.add broadcaster_3, express_delivery

        expect(subject.total_cost).to eq(35)
      end

      it 'initiates a 10% discount if total cost is over 30' do
        subject.add broadcaster_4, standard_delivery
        expect(subject.total_cost).to eq(36)
      end

      it 'returns the total cost of all items after discount' do
        subject.add broadcaster_5, standard_delivery
        subject.add broadcaster_6, standard_delivery

        expect(subject.total_cost).to eq(45)
      end
    end
  end
