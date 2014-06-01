class LolPicsController < ApplicationController
  def lol
  	# Save the ID
    LolPic.new("url" => params[:url], "uid" => User.find(session[:user_id]).uid).save!
  	rescue ActiveRecord::RecordNotUnique

    return;
  end

  # Show all pics
  def show
  	@lols = LolPic.where(:uid => User.find(session[:user_id]).uid)
  end
end
