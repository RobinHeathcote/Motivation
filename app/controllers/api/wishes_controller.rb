class Api::WishesController < ApplicationController
  before_action :authenticate_api_user!

  respond_to :json

  def show
    render json: current_api_user.wishes.find(params[:id])
  end

  def index
    render json: current_api_user.wishes
  end

  def create
    wish = current_api_user.wishes.build(wish_params)
    if wish.save
      render json: wish, status: 201, location: [:api, wish]
    else
      render json: {errors: wish.errors }, status: 422
    end
  end

  def update
    wish = current_api_user.wishes.find(params[:id])
    if wish.update(wish_params)
      render json: wish, status: 200, location: [:api, wish]
    else
      render json: { errors: wish.errors }, status: 422
    end
  end

  def destroy
    wish = current_api_user.wishes.find(params[:id])
    wish.destroy
    head 204
  end

  private

  def wish_params
    params.require(:wish).permit(:wish_text, :outcome_text)
  end
end
