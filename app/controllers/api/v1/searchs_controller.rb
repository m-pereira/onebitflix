class Api::V1::SearchsController < ApplicationController
  include SearchHelper

  def index
    check_search_value && (return if performed?)

    @search = PgSearch.multisearch(params[:value]).order(created_at: :desc).map(&:searchable)

    render json: serialize_collection(@search)
  end

  private

  def check_search_value
    return if params[:value].present? && params[:value].length >= 3

    render json: { errors: 'Parameter :value must have at least 3 characters' },
      status: :unprocessable_entity
  end
end
