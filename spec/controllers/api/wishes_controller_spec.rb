require 'rails_helper'

RSpec.describe Api::WishesController, type: :controller do

  describe "GET show" do
    context "user could see own wish" do
      before(:each) do
        @user = FactoryGirl.create :user
        @wish = FactoryGirl.create :wish, user: @user
        auth_request(@user)
        get :show, id: @wish.id
      end

      it 'returns wish as a hash' do
        expect(json_response[:wish_text]).to eq @wish.wish_text
      end

      it {should respond_with 200}
    end
  end

  describe "GET #index" do

    context "user could see all his own wishes" do
      before(:each) do
        @user = FactoryGirl.create :user
        4.times {FactoryGirl.create :wish, user: @user}
        auth_request(@user)
        get :index
      end


      it "returns 4 records from the database" do
        expect(json_response.length).to eq 4
      end

      it {should respond_with 200}
    end

  end

  describe "POST #create" do
    context "when the wish is valid" do
      before(:each) do
        user = FactoryGirl.create :user
        @wish_attributes = FactoryGirl.attributes_for :wish
        auth_request(user)
        post :create, {user_id: user.id, wish: @wish_attributes}
      end

      it "renders the json representation for the wish we just created" do
        expect(json_response[:wish_text]).to eq @wish_attributes[:wish_text]
      end

      it {should respond_with 201 }
    end

    context "when the wish is invalid" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_wish_attributes = { wish_text: "hello"}
        auth_request(user)
        post :create, {user_id: user.id, wish: @invalid_wish_attributes}
      end

      it "does not change the total amount of wishes" do
        expect(Wish.count).to eq 0
      end

      it "renders an error json" do
        wish_response = json_response
        expect(wish_response).to have_key(:errors)
      end

      it {should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @wish = FactoryGirl.create :wish, user: @user
      auth_request(@user)
    end

    context "when the updating is successful" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @wish.id, wish: { wish_text: 'hello' } }
      end

      it 'return the json object of the updated wish' do
        wish_response = json_response
        expect(wish_response[:wish_text]).to eq 'hello'
      end

      it { should respond_with 200 }
    end

    # context "when update is unsuccessful" do

    # end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @wish = FactoryGirl.create :wish, user: @user
      auth_request(@user)
      delete :destroy, { user_id: @user.id, id: @wish.id }
    end

    it { should respond_with 204 }
  end
end
