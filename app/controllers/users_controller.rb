class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
      @user = User.find_by(username: params[:id])
  end

  def new
    # form for adding new user
    @user = User.new
  end

  def create
    # take parameters from the form and create a new form
    # create a new user
    # if its valid and it saves then go to the list users page
    # if not see form with errors
    @user = User.new(form_params)
    if @user.save
      # save the session with the user
      session[:user_id] = @user.id
      redirect_to users_path
    else
      render "new"
    end
  end


  def form_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
