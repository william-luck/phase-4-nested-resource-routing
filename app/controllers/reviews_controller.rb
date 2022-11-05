class ReviewsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


  def index
    # Depending on whether a dog_house_id was passed in the URL params, we will either get reveiws for a specific dog house or all reviews. Because we have two routes with the same controller action (check rails routes)
    if params[:dog_house_id]
      dog_house = DogHouse.find(params[:dog_house_id])
      reviews = dog_house.reviews
    else
      reviews = Review.all
      render json: reviews, include: :dog_house
    end
  end

  def show
    review = Review.find(params[:id])
    render json: review, include: :dog_house
  end

  def create
    review = Review.create(review_params)
    render json: review, status: :created
  end

  private

  def render_not_found_response
    render json: { error: "Review not found" }, status: :not_found
  end

  def review_params
    params.permit(:username, :comment, :rating)
  end

end
