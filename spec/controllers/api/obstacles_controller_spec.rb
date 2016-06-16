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

    context "user could not see an obstacle of others" do
      before(:each) do
        @user = FactoryGirl.create :user
        @user_2 = FactoryGirl.create :user
        @wish = FactoryGirl.create :wish, user: @user
        @obstacle = FactoryGirl.create :obstacle, wish: @wish
        auth_request(@user_2)
        get :show, {wish_id: @wish.id, id: @obstacle.id}
      end

      it { should respond_with 401 }

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

      it { should respond_with 401 }

    end
  end

  describe "POST #create" do
    context "when the obstacle is valid" do
      before(:each) do
        user = FactoryGirl.create :user
        wish = FactoryGirl.create :wish, user: user
        @obstacle_attributes = FactoryGirl.attributes_for :obstacle
        auth_request(user)
        post :create, {wish_id: wish.id, obstacle: @obstacle_attributes}
      end

      it "renders the json representation for the obstacle we just created" do
        expect(json_response[:obstacle_text]).to eq @obstacle_attributes[:obstacle_text]
      end

      it "increase the number of obstacles by 1" do
        expect(Obstacle.count).to eq 1
      end

      it {should respond_with 201}

    end

    context "when obstacle is invalid" do
      before(:each) do
        user = FactoryGirl.create :user
        wish = FactoryGirl.create :wish, user: user
        @invalid_obstacle_attributes = { obstacle_text: "hello"}
        auth_request(user)
        post :create, {wish_id: wish.id, obstacle: @invalid_obstacle_attributes}
      end

      it {should respond_with 422}

      it "renders an error json" do
        obstacle_response = json_response
        expect(obstacle_response).to have_key(:errors)
      end

      it "does not change the total amount of obstacles" do
        expect(Obstacle.count).to eq 0
      end
    end
  end

end
