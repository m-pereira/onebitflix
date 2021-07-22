class Api::V1::MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])

    render json: @movie
  end
end
