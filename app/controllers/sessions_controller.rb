class SessionsController < ApplicationController
  def create
  	# render :text => request.env["omniauth.auth"].to_yaml
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    
    # TODO: Save the user.oauth_token and .oauth_secret into database
    $client = Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.secrets.consumer_key
      config.consumer_secret = Rails.application.secrets.consumer_secret
      config.access_token = user.oauth_token
      config.access_token_secret = user.oauth_secret
    end

    redirect_to root_path
  end
 
  def destroy
    session[:user_id] = nil

    #TODO: Delete the user.oauth_token and .oauth_secret from database
    
    redirect_to root_path
  end
end
