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
    # This takes information from the form and adds it to the model
    @review = Review.new(form_params)
    # Check if review can be saved
    # If it can then save it and redirect to home
    # If it cannot be saved then stay on same page
    if @review.save
      redirect_to root_path
    else
      render new
    end
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

  def edit
    # Find individual review to edit review

    @review = Review.find(params[:id])
  end

  def update
    # Find indivdual review
    @review = Review.find(params[:id])
    # Update review
    if @review.update(form_params)
    #redirect to review page
      redirect_to review_path(@review)
    else
      render "edit"
    end
  end

  def form_params
    params.require(:review).permit(:title, :body, :score)
  end

end
