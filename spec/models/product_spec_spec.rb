require 'rails_helper'

RSpec.describe Product, type: :model do

  describe "Validations" do

    let(:category) { Category.create(name: "Test Category") }

    context "Invalid Instances" do
    
      it "should be invalid if :name is NOT present" do
        product = Product.new(name: nil, price_cents: 100, quantity: 1, category: category)
        expect(product).to_not be_valid
        expect(product.errors[:name]).to include("can't be blank")
      end

      it "should be invalid if :price is NOT present" do
        product = Product.new(name: "test product", price_cents: nil, quantity: 1, category: category)
        expect(product).to_not be_valid
        expect(product.errors[:price_cents]).to include("is not a number")
      end

      it "should be invalid if :quantity is NOT present" do
        product = Product.new(name: "test product", price_cents: 100, quantity: nil, category: category)
        expect(product).to_not be_valid
        expect(product.errors[:quantity]).to include("can't be blank")
      end

      it "should be invalid if :category is NOT present" do
        product = Product.new(name: "test product", price_cents: 100, quantity: 1, category: nil)
        expect(product).to_not be_valid
        expect(product.errors[:category]).to include("can't be blank")
      end

    end

    context "Valid Instances" do
      
      it "should be valid with all attributes present" do
        product = Product.new(name: "test product", price_cents: 100, quantity: 1, category: category)
        expect(product).to be_valid
        expect(product.name).to eql("test product")
        expect(product.price_cents).to eql(100)
        expect(product.quantity).to eql(1)
        expect(product.category).to eql(category)
      end

    end

  end

end
