class Api::V1::DashboardsController < ApplicationController
  include SearchHelper

  def index
    type_whitelist && (return if performed?)

    @result = LastSeenResourceFinder.call(params[:type], current_user)

    render json: @result
  end

  private

  def type_whitelist
    params[:type] ||= 'category'

    return if permitted_types.include?(params[:type])

    render json: { errors: 'Unpermitted type parameter' }, status: :forbidden
  end

  def permitted_types
    %w[category keep_watching highlight]
  end
end
