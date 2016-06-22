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

      it "returns 0 records from the database" do
        expect(json_response.length).to eq 0
      end

    end
  end
end
