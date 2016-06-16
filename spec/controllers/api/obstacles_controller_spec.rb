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
    end
  end
end