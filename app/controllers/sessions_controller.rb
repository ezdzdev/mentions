class SessionsController < ApplicationController
  # Create session and user
  def create
  	# Create the user record
    user = User.from_omniauth(env["omniauth.auth"],request.remote_ip)
    # Create the user_id in session
    session[:user_id] = user.id

    redirect_to root_path
  end
 
  # Destory session and user
  def destroy
    # Delete the user access tokens on logout
    User.find(session[:user_id]).delete
    # Delete the session as well
    session = {}
    
    redirect_to root_path
  end
end
