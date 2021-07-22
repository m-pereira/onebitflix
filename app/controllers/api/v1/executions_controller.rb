class Api::V1::ExecutionsController < ApplicationController
  before_action :set_execution, only: :update
  # skip_before_action :verify_authenticity_token

  def show
    @movie = Movie.find(params[:id])
    @player = @movie.players.find_or_create_by(end_date: nil, user: current_user)

    render json: @player
  end

  def update
    @player.update(player_params)

    render json: @player

    # if @player.update(player_params)
    #   render json: @player
    # else
    #   render json: { errors: @player.errors.full_messages }, status: :unprocessable_entity
    # end
  end

  private

  def player_params
    params.require(:execution).permit(:elapsed_time, :end_date).merge(user: current_user)
  end

  def set_execution
    @player = Player.where(user: current_user).find_by(movie_id: params[:id])
  end
end
