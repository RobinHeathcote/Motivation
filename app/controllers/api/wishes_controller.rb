class Api::WishesController < ApplicationController
  respond_to :json

  def show
    render json: Wish.find(params[:id])
  end

end
