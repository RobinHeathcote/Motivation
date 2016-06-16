require 'rails_helper'

RSpec.describe Api::ObstaclesController, type: :controller do

  describe "GET show" do
    context "user could see an obstacle of his own wish" do
      before(:each) do
        @user = FactoryGirl.create :user
        @wish = FactoryGirl.create :wish, user: @user
        @obstacle = FactoryGirl.create :obstacle, wish: @wish
        auth_request(@user)
        get :show, {wish_id: @wish.id, id: @obstacle.id}
      end

      it 'return obstacle as a hash' do
        expect(json_response[:obstacle_text]).to eq @obstacle.obstacle_text
      end

      it {should respond_with 200}
    end
  end

  describe "Get #index" do

    context "user could see his own obstables" do
      before(:each) do
        @user = FactoryGirl.create :user
        @wish = FactoryGirl.create :wish, user: @user
        4.times { FactoryGirl.create :obstacle, wish: @wish }
        auth_request(@user)
        get :index, wish_id: @wish.id
      end

      it "returns 4 records from the database" do
        expect(json_response.length).to eq 4
      end

      it {should respond_with 200}
    end

    context "user could not see obstacles others created" do
      before(:each) do
        @user = FactoryGirl.create :user
        @user_2 = FactoryGirl.create :user
        @wish = FactoryGirl.create :wish, user: @user
        4.times { FactoryGirl.create :obstacle, wish: @wish }
        auth_request(@user_2)
        get :index, wish_id: @wish.id
      end

      it "returns 0 records from the database" do
        expect(json_response.length).to eq 0
      end
    end  
  end

end
