class LolPicsController < ApplicationController
  def lol
  	# The ID is always last
  	pid = params[:id].scan(/\d+/).last
	  render :nothing => true
    
  	# Save the ID
  	$tweetPics.find do |pic|
  		if (pic.pid == pid.to_s)
    		pic.uid = User.take.uid
  		  pic.save!
      end
  	end
  	rescue ActiveRecord::RecordNotUnique
  end

  # Show all pics
  def show
  	@lols = LolPic.where(:uid => User.take.uid)
  end
end
