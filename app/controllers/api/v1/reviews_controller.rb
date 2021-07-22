class Api::V1::ReviewsController < ApplicationController
  def index
    @reviews = Review.where(user: current_user)

    render json: @reviews
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      render json: @review, status: :created
    else
      render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :reviewable_type,
      :reviewable_id,
      :rating,
      :description
    ).merge(user: current_user)
  end
end
