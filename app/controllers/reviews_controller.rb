class ReviewsController < ApplicationController

  def index
    # This is out list page for our reviews
    @reviews = ["Nandos", "Five Guys", "Chipotle"]
  end

  def new
    # This is the form for adding a new review 
    @review = Review.new
  end

end
