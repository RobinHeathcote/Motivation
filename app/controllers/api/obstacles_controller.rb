class Api::ObstaclesController < ApplicationController
  before_action :authenticate_api_user!
  before_action :user_can_access_wish?
  respond_to :json

  def show
    render json: Obstacle.find(params[:id])
  end

  def index
    wish = Wish.find(params[:wish_id])
    render json: wish.obstacles
  end

  def create
    wish = Wish.find(params[:wish_id])
    obstacle = wish.obstacles.build(obstacle_params)
    if obstacle.save
      render json: obstacle, status: 201
    else
      render json: {errors: obstacle.errors }, status: 422
    end
  end

  def update
    obstacle = Obstacle.find(params[:id])
    if obstacle.update(obstacle_params)
      render json: obstacle, status: 200
    else
      render json: { errors: obstacle.errors }, status: 422
    end
  end

  def destroy
    obstacle = Obstacle.find(params[:id])
    obstacle.destroy
    head 204
  end

  private

  def obstacle_params
    params.require(:obstacle).permit(:obstacle_text, :plan_text)
  end

  def user_can_access_wish?
    wish = Wish.find(params[:wish_id])
    render nothing: true, status: :unauthorized unless user_own_wish?(wish)
  end

  def user_own_wish?(wish)
    current_api_user.wishes.include?(wish)
  end

  # def user_own_obstacle?
  #   obstacle = Obstacle.find(params[:id])
  #   render nothing: true, status: :unauthorized unless user_own_wish?(obstacle.wish)
  # end
end
