class HomeController < ApplicationController 
  # Show (root)
  def show
  end

  # Search for mentions
  def search
  	# Process search based on param, or a clean search
    if ( params[:cmd] == 'next' )   
      request_results = $client.search($username, :result_type => 'recent', :max_id => $last_id, :count => 5)

    elsif ( params[:cmd] == 'prev')
      request_results = $client.search($username, :result_type => 'recent', :since_id => $first_id, :count => 5)

    else
      # Save username for this search
      $username = params[:home][:username]
      request_results = $client.search($username, :result_type => 'recent', :count => 5)

    end

    # Process results
    @tweetCount = 0
    tweetIDs = []
    request_results.each do |tweet|
  	  tweetIDs.push(tweet.id)
  	  @tweetCount += 1
  	end

  	# Save some variables
  	$first_id = tweetIDs.first
  	$last_id = tweetIDs.last

  	puts $first_id
  	puts $last_id

  	@mentions = $client.oembeds(tweetIDs)
  end
end
