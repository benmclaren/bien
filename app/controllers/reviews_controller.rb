class ReviewsController < ApplicationController

  #check if user is logged in
  before_action :check_login, except: [:index, :show]

  def index
    # This is out list page for our reviews
    @price = params[:price]
    @cuisine = params[:cuisine]
    @location = params[:location]

    # start with all Reviews

    @reviews = Review.all

    # filter by Price
    if @price.present?
      @reviews = @reviews.where(price: @price)
    end

    # filter by cuisine
    if @cuisine.present?
      @reviews = @reviews.where(cuisine: @cuisine)
    end

    # filter by location
    if @location.present?
      @reviews = @reviews.near(@location)
    end

  end

  def new
    # This is the form for adding a new review
    @review = Review.new
  end

  def create
    # This takes information from the form and adds it to the model
    @review = Review.new(form_params)

    # associate this with the current user. There is always a user becuase of the check_login
    @review.user = @current_user

    # Check if review can be saved
    # If it can then save it and redirect to home
    # If it cannot be saved then stay on same page
    if @review.save!
      redirect_to root_path
    else
      render "new"
    end
  end

  def show
    # This is the individual show page
    @review = Review.find(params[:id])
  end

  def destroy
    # Find the individual review
      @review = Review.find(params[:id])
        # destroy if they have access
      if @review.user == @current_user
        # Destroy
        @review.destroy
      end
    # Redirect to home homepage
    redirect_to root_path
  end

  def edit
    # Find individual review to edit review
    @review = Review.find(params[:id])

    # This says if the review does not equal the current user then redirect to the homepage
    if @review.user != @current_user
      redirect_to root_path
    elsif @review.created_at < 1.hour.ago
      redirect_to review_path(@review)
    end
  end

  def update
    # Find indivdual review
    @review = Review.find(params[:id])
    if @review.user != @current_user
      redirect_to root_path
    else
      # Update review
      if @review.update(form_params)
      #redirect to review page
        redirect_to review_path(@review)
      else
        render "edit"
      end
    end
  end


  def form_params
    params.require(:review).permit(:title, :restaurant, :body, :ambience, :price, :cuisine, :score, :address, :photo)
  end

end
