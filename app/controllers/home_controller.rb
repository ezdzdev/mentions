class HomeController < ApplicationController
  def show
  end

  def search
  	require 'twitter'

  	client = Twitter::REST::Client.new do |config|
		config.consumer_key = Rails.application.secrets.consumer_key
		config.consumer_secret = Rails.application.secrets.consumer_secret
		config.access_token = current_user.oauth_token
		config.access_token_secret = current_user.oauth_secret
	end

	# TODO: get more tweets -> save last tweet id, search again with max_id = last_id
	@tweet_news = client.search(params[:home][:username], :result_type => 'recent')
  end
end
