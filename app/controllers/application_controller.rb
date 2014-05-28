class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user 

  # Easy access to current user pointer 
  def current_user
  	# We need both remote_ip and session_id to be 'logged in'
    # in the case that we don't have our session info but server has our login info, we recover by grabbing our session info with our remote_ip
    # in the case that server doesn't not have login info but we have our session info, log in is required
    # in the case where we have neither, log in is required
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end
end
