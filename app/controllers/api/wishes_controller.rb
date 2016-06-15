class Api::WishesController < ApplicationController
  before_action :authentication_with_token!, only: [:create, :update, :destroy]
  respond_to :json

  def show
    render json: Wish.find(params[:id])
  end

  def index
    render json: Wish.all
  end
  #needs to be updated to show only the wishes of the current user!

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

  def update
    wish = current_user.wishes.find(params[:id])
    if wish.update(wish_params)
      render json: wish, status: 200, location: [:api, wish]
    else
      render json: { errors: wish.errors }, status: 422
    end
  end

  def destroy
    wish = current_user.wishes.find(params[:id])
    wish.destroy
    head 204
  end



  private

  def wish_params
    params.require(:wish).permit(:wish_text, :outcome_text)
  end
end
