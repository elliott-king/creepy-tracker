class UsersController < ApplicationController
  helper_method :google_tags

  def index
    puts google_tags
    if google_tags[:ga]
      @user = User.find_or_create_by(ga: google_tags[:ga])

      if @user.last_visit
        @last_visit = @user.last_visit
      end
      @user.hits += 1
      @user.last_visit = Time.now
      @user.save
    else 
      @user = User.new
    end
    render :index
  end

  private
  def google_tags
    {
      gat_gtag_UA_158940829_2: cookies[:_gat_gtag_UA_158940829_2],
      ga: cookies[:_ga],
      gid: cookies[:_gid]
    }
  end
end