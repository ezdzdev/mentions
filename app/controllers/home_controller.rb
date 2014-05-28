class HomeController < ApplicationController 
  # Show (root)
  def show
  end

  # Search for mentions
  def search
  	# Process search based on param, or a clean search
    if ( params[:cmd] == 'more' )   
      request_results = $client.search($username, :result_type => 'recent', :max_id => $last_id - 1)

    else
      # Save username for this search
      $username = params[:home][:username]
      $mentions = []
      request_results = $client.search('@' + $username, :result_type => 'recent')
    end

    # Process results
    @tweetCount = 0
    tweetIDs = []
    request_results.each do |tweet|
  	  tweetIDs.push(tweet.id)
  	  @tweetCount += 1

  	  # Because twitter is stupid
  	  break unless @tweetCount < 5
  	end

  	# Save the last id
  	$last_id = tweetIDs.last

  	# Get the embedded tweets
  	$mentions += $client.oembeds(tweetIDs)
  end
end
