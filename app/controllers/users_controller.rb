class UsersController < ApplicationController
  helper_method :google_tags

  def index
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

  def create
    # Handling AJAX on server side: https://guides.rubyonrails.org/working_with_javascript_in_rails.html#server-side-concerns
    # TODO: serialize plugins like they do @ panopticlick.eff.org
    # byebug
    user_info = params[:user_info].permit!.merge(browser_measurements)
    user_info = user_info.to_s
    @fingerprint_user =  User.find_or_create_by(fingerprint: user_info)
    if @fingerprint_user.last_visit
      @fingerprint_last_visit = @fingerprint_user.last_visit
        end
    @fingerprint_user.hits += 1
    @fingerprint_user.last_visit = Time.now 
    @fingerprint_user.save
    end
    # byebug
  end

  private
  def google_tags
    {
      gat_gtag_UA_158940829_2: cookies[:_gat_gtag_UA_158940829_2],
      ga: cookies[:_ga],
      gid: cookies[:_gid]
    }
  end

  def browser_measurements
    {
      user_agent: request.user_agent,
      # TODO: not sure where the accept text/html header is
      accept_headers: request.headers[:accept],
      accept_encoding: request.headers["accept-encoding"],
      accept_language: request.headers["accept-language"],
      cookies_enabled: !request.cookies.blank?,
    }
  end

  def serialize_user_info(user_info)
    s = "#{user_info[:width]}x#{user_info[:height]}x#{user_info[:depth]}"
    s += "#{user_info[:user_agent]}#{user_info[:accept_headers]}#{user_info[:accept_encoding]}#{user_info[:accept_language]}"
    s += user_info[:cookies_enabled].to_s
    s += user_info[:timezone].to_s
    s += user_info[:fonts].join("")
    s += user_info[:plugins].join("")
  end
end