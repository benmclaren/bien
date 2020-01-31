class ReviewsController < ApplicationController

  def index
    # This is out list page for our reviews
    @reviews = Review.all
  end

  def new
    # This is the form for adding a new review
    @review = Review.new
  end

  def create
    # This takes information from the form and adds it to the database
    @review = Review.new(params.require(:review).permit(:title, :body, :score))

    # Save the review to the database
    @review.save

    # Redirect to homepage
    redirect_to root_path
  end

  def show
    # This is the individual show page
    @review = Review.find(params[:id])
  end

  def destroy
    # Find the individual review
    @review = Review.find(params[:id])
    # Destroy
    @review.destroy
    # Redirect to home homepage
    redirect_to root_path
  end

end
