class Api::ObstaclesController < ApplicationController
  before_action :authenticate_api_user!

  respond_to :json

  def show
    render json: Obstacle.find(params[:id])
  end

  private

  def obstacle_params
    params.require(:obstacle).permit(:obstacle_text, :plan_text)
  end

end