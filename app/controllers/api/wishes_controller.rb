class Api::WishesController < ApplicationController
  before_action :authentication_with_token!, only: [:create]
  respond_to :json

  def show
    render json: Wish.find(params[:id])
  end

  def index
    render json: Wish.all
  end

  def create
    wish = current_user.wishes.build(wish_params)
    if wish.save
      render json: wish, status: 201, location: [:api, wish]
      #return the newly created wish object
    else
      render json: {errors: product.errors }, status: 422
      #return an error object for the front-end to use
    end
  end

  private

  def wish_params
    params.require(:wish).permit(:wish_text, outcome_text)
  end
end
