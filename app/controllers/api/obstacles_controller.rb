class Api::ObstaclesController < ApplicationController
  before_action :authenticate_api_user!

  respond_to :json

  def show
    obstacle = Obstacle.find(params[:id])
    if user_own_wish?(obstacle.wish)
      render json: obstacle
    else
      head 401
    end
  end

  def index
    wish = Wish.find(params[:wish_id])
    if user_own_wish?(wish)
      render json: wish.obstacles
    else
      head 401
    end
  end

  private

  def obstacle_params
    params.require(:obstacle).permit(:obstacle_text, :plan_text)
  end

  def user_own_wish?(wish)
    current_api_user.wishes.include?(wish)
  end

end
