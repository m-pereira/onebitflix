class Api::V1::FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorites
    render json: @favorites
  end

  def create
    @favorite = Favorite.new(favorite_params)

    if @favorite.save
      head :created
    else
      render json: { errors: @favorite.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite = Favorite.where(user: current_user).find_by(
      favoritable_type: params[:type].capitalize,
      favoritable_id: params[:id]
    )
    @favorite.destroy

    head :ok
  end

  private

  def favorite_params
    params.require(:favorite).permit(:favoritable_type, :favoritable_id).merge(user: current_user)
  end
end
