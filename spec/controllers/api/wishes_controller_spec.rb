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

  describe "POST #create" do
    context "when the wish is valid" do
      before(:each) do
        user = FactoryGirl.create :user
        @wish_attributes = FactoryGirl.attributes_for :wish
        api_authorization_header user.auth_token
        post :create, {user_id: user.id, wish: @wish_attributes}
      end

      it "renders the json representation for the wish we just created" do
        wish_response = JSON.parse(response.body)
        expect(wish_response["wish_text"]).to eq @wish.wish_text
      end

      it {should respond_with 201 }
    end

    context "when the wish is invalid" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_wish_attributes = { wish_text: "hello"}
        api_authorization_header user.auth_token
        post :create, {user_id: user.id, wish: @invalid_wish_attributes}
      end

      it "renders an error json" do
        wish_response = JSON.parse(response.body)
        expect(wish_responseh).to have_key(:errors)
      end

      it {should respond_with 422 }
    end

  end
end
