require 'rails_helper'

RSpec.describe Api::WishesController, type: :controller do

  describe "GET show" do
    before(:each) do
      @wish = FactoryGirl.create :wish
      get :show, id: @wish.id
    end

    it 'returns wish as a hash' do
      product_response = JSON.parse(response.body)
      p product_response
      expect(product_response["wish_text"]).to eq @wish.wish_text
    end

    it {should respond_with 200}
  end
end
