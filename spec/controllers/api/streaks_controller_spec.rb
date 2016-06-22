require 'rails_helper'

RSpec.describe Api::StreaksController, type: :controller do

  describe "GET #index" do

    context "user could see all his own streaks" do
      before(:each) do
        @user = FactoryGirl.create :user
        @wish = FactoryGirl.create :wish, user: @user
        @obstacle = FactoryGirl.create :obstacle, wish: @wish
        4.times {FactoryGirl.create :streak, obstacle: @obstacle}
        auth_request(@user)
        get :index, wish_id: @wish.id, obstacle_id: @obstacle.id
      end

      it 'returns 4 records from the database' do
        expect(json_response.length).to equal 4
      end

      it {should respond_with 200}
    end

    context "user could not see obstacles others created" do
      before(:each) do
        @user = FactoryGirl.create :user
        @user_2 = FactoryGirl.create :user
        @wish = FactoryGirl.create :wish, user: @user
        @obstacle = FactoryGirl.create :obstacle, wish: @wish
        4.times {FactoryGirl.create :streak, obstacle: @obstacle}
        auth_request(@user_2)
        get :index, wish_id: @wish.id, obstacle_id: @obstacle.id
      end

      it { should respond_with 401 }
    end

  end

  describe "POST #create" do
    context "when streak is valid" do
      before(:each) do
        @user = FactoryGirl.create :user
        @wish = FactoryGirl.create :wish, user: @user
        @obstacle = FactoryGirl.create :obstacle, wish: @wish
        @streak_attributes = FactoryGirl.attributes_for :streak
        auth_request(@user)
        post :create, {wish_id: @wish.id, obstacle_id: @obstacle.id, streak: @streak_attributes}
      end

      it "renders the json representation" do
        expect(json_response[:completed]).to eq true
      end

      it "increase the number of streaks by 1" do
        expect(Streak.count).to eq 1
      end

      it {should respond_with 201}
    end

    context 'when streak is invalid' do
      before(:each) do
        @user = FactoryGirl.create :user
        @wish = FactoryGirl.create :wish, user: @user
        @obstacle = FactoryGirl.create :obstacle, wish: @wish
        @invalid_streak_attributes = { completed: nil }
        auth_request(@user)
        post :create, {wish_id: @wish.id, obstacle_id: @obstacle.id, streak: @invalid_streak_attributes}
      end

      it {should respond_with 422}
    end
  end

end
