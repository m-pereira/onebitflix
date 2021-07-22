class Api::V1::SeriesController < ApplicationController
  def show
    @serie = Serie.find(params[:id])

    render json: @serie
  end
end
