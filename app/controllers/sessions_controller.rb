class SessionsController < ApplicationController
  def new
    # login form
  end

  def create
    # actually try and login
    @form_data = params.require(:session)

    # pull out the username and password from the form_data
    @username = @form_data[:username]
    @password = @form_data[:password]

    # lets check the user is who they say they are
    @user = User.find_by(username: @username).try(:authenticate, @password)

    # if there is a user present, reditect to the home page
    if @user
      # save this user to that users specific session
      session[:user_id] = @user.id

      redirect_to root_path
    else
      render "new"
    end

  end

  def destroy
    # log out
    # remove the session completely
    # this says get rid of anything the user has assigned to me
    reset_session

    # redirect to the login page
    redirect_to new_session_path
  end
end
