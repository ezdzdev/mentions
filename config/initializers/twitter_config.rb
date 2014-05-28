$client = Twitter::REST::Client.new do |config|
  config.consumer_key = Rails.application.secrets.consumer_key
  config.consumer_secret = Rails.application.secrets.consumer_secret
  config.access_token = User.take.oauth_token
  config.access_token_secret = User.take.oauth_secret
end