class HomeController < ApplicationController 
  # Show (root)
  def show
  	# Recover our session id if possible
  	session[:user_id] ||= User.where(rip: request.remote_ip.to_s).first.id if User.where(rip: request.remote_ip.to_s).any?
	end


  # Search for mentions
  def search
    require 'twitter'

    # Setup client object for querying
    client = Twitter::REST::Client.new do |config| 
      config.consumer_key = Rails.application.secrets.consumer_key
      config.consumer_secret = Rails.application.secrets.consumer_secret
      config.access_token = User.find(session[:user_id]).oauth_token
      config.access_token_secret = User.find(session[:user_id]).oauth_secret
    end if session[:user_id]

  	# Process search based on param, or a clean search
    if ( params[:cmd] == 'next' )
      @tweets = client.search('@' + session[:username], :result_type => 'recent', :max_id => session[:last_id] - 1)

    elsif ( params[:cmd] == 'prev' )
      @tweets = client.search('@' + session[:username], :result_type => 'recent', :since_id => session[:since_id] + 1)      
    else
      # Overwrite username in session
      
      session[:username] = params[:home][:username] unless params[:home][:username] == nil
      @tweets = client.search('@' + session[:username], :result_type => 'recent')
    end

    # Need IDs, no first or last function
    @tweetIDs = []
    @tweets.each do |tweet|
  	  @tweetIDs.push(tweet.id)
  	end

  	# Save the last id
  	session[:last_id] = @tweetIDs.last
    session[:since_id] = @tweetIDs.first
  end
end
