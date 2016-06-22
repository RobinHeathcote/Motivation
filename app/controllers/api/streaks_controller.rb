class Api::StreaksController < ApplicationController
  before_action :authenticate_api_user!
  before_action :set_obstacle
  before_action :user_can_access_streak?
  respond_to :json

  def index
    obstacle = Obstacle.find(params[:obstacle_id])
    render json: obstacle.streaks
  end

  def create
    streak = obstacle.streaks.build(streak_params)
    if streak.save
      render json: streak, status: 201
    else
      render json: {errors: streak.errors }, status: 422
    end
  end

  private

  def set_obstacle
    obstacle = Obstacle.find(params[:obstacle_id])
  end

  def streak_params
    params.require(:streak).permit(:completed)
  end

  def user_can_access_streak?
      render nothing: true, status: :unauthorized unless user_own_streak?
  end

  def user_own_streak?
    obstacle = Obstacle.find(params[:obstacle_id])
    obstacle.wish.user == current_api_user
  end
  
end
