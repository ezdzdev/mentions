class SessionsController < ApplicationController
  def create
  	# Create the user record
    user = User.from_omniauth(env["omniauth.auth"])

    # Create the user_id in session
    session[:user_id] = user.id
    
    redirect_to root_path
  end
 
  def destroy
    # Delete the user access tokens on logout
    User.find(session[:user_id]).delete

    # Delete the session as well
    session = {}
    
    redirect_to root_path
  end
end
