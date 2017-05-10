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
      it 'is instantiated with a material' do
        expect(subject.material.identifier).to eq('HON/TEST001/010')
      end
    end
  end
