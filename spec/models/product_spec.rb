require 'rails_helper'

RSpec.describe Product do
  let!(:category1) { FactoryBot.create :category, name: 'Category1' }
  let!(:product) { FactoryBot.create :product, name: 'Jeans', category: category1 }

  context 'associations' do
    it { should belong_to(:category) }
    it { should have_many(:comments) }
    it { should have_many(:concrete_products) }
    it { should have_many(:productrates) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:category) }
  end

  describe '#rate' do
    it do
      expect(product.rate).to eq(0)
    end

    context 'when product has been rated' do
      let!(:rate1) { FactoryBot.create :productrate, product: product, rate: 4 }
      let!(:rate2) { FactoryBot.create :productrate, product: product, rate: 3 }

      it 'should be average rates returned' do
        expect(product.rate).to eq(3)
      end
    end
  end
end
