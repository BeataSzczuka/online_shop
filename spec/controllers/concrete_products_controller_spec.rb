require 'rails_helper'

RSpec.describe ConcreteProductsController do
  let(:category) { FactoryBot.create :category }
  let(:product) { FactoryBot.create :product, name: 'jeans', category: category }
  let(:concrete_product) do
    FactoryBot.create :concrete_product, price: 2000, size: 'S', color: 'blue',
                                         amount: 6, product: product
  end

  describe 'POST #add_to_cart' do
    subject { post :add_to_cart, params: { id: concrete_product.id } }

    before do
      allow(AddToCart).to receive(:run).and_return(outcome)
    end

    context 'guest can add item to cart' do
      let(:outcome) { instance_double(AddToCart, valid?: true) }
      it do
        subject
        expect(controller.flash[:notice]).to eq('Dodano do koszyka')
      end
      it do
        expect(subject).to redirect_to(products_path)
      end
    end

    context 'guest can not add item to cart' do
      let(:outcome) { instance_double(AddToCart, valid?: false, errors: errors) }
      let(:errors) { Struct.new(:full_messages).new('Item is not available') }
      it do
        subject
        expect(controller.flash[:notice]).to eq('Item is not available')
      end
      it do
        expect(subject).to redirect_to(products_path)
      end
    end
  end
end
