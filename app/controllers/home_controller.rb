class HomeController < ApplicationController 
  # Show (root)
  def show
  	# Recover our session id if possible
  	if User.where(rip: request.remote_ip.to_s).any? 
		session[:user_id] ||= User.where(rip: request.remote_ip.to_s).first.id 
		# Set up client
	    $client ||= Twitter::REST::Client.new do |config| 
	      config.consumer_key = Rails.application.secrets.consumer_key
	      config.consumer_secret = Rails.application.secrets.consumer_secret
	      config.access_token = User.find(session[:user_id]).oauth_token
	      config.access_token_secret = User.find(session[:user_id]).oauth_secret
		end if session[:user_id]
	end

  	
  end

  # Search for mentions
  def search
  	# Process search based on param, or a clean search
    if ( params[:cmd] == 'more' )   
      request_results = $client.search('@' + $username, :result_type => 'recent', :max_id => $last_id - 1)

    else
      # Reset some global vars 
      $username = params[:home][:username]
      $mentions = []
      $tweetPics = []

      request_results = $client.search('@' + $username, :result_type => 'recent')
    end

    # Process results for Oembed and lol pics
    @tweetIDs = []
    request_results.each do |tweet|
      # If media is present, we want to create a new LolPic, but we don't save until it gets lol'd
      $tweetPics.push(LolPic.new("pid" => tweet.id.to_s, "url" => tweet.media[0]['media_url'].to_s)) if tweet.media.present?
  	  @tweetIDs.push(tweet.id);

  	  # Because twitter is stupid
  	  # (oembed request times out if there are too many ids)
  	  # (at the same time, search request applies $count amount after $max_id)
  	  # (so we need to manually enforce $count)
  	  break unless @tweetIDs.count < 5
  	end

  	# Save the last id
  	$last_id = @tweetIDs.last

  	# Get the embedded tweets
  	$mentions += $client.oembeds(@tweetIDs)
  end
end
