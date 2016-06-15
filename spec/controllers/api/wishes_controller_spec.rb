require 'rails_helper'

RSpec.describe Api::WishesController, type: :controller do

  describe "GET show" do
    before(:each) do
      @wish = FactoryGirl.create :wish
      get :show, id: @wish.id
    end

    it 'returns wish as a hash' do
      wish_response = JSON.parse(response.body)
      expect(wish_response["wish_text"]).to eq @wish.wish_text
    end

    it {should respond_with 200}
  end

  describe "GET #index" do
    before(:each) do
      4.times {FactoryGirl.create :wish}
      get :index
    end

    it "returns 4 records from the database" do
      wishes_response = JSON.parse(response.body)
      expect(wishes_response.length).to eq 4
    end

    it {should respond_with 200}
  end
end
