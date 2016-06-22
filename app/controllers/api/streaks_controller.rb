class Api::StreaksController < ApplicationController
  before_action :authenticate_api_user!
  before_action :set_obstacle
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
end
