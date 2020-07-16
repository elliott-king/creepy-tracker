class UsersController < ApplicationController
  helper_method :google_tags

  def index
    render :index
  end

  def create
    # Handling AJAX on server side: https://guides.rubyonrails.org/working_with_javascript_in_rails.html#server-side-concerns
    # TODO: serialize plugins like they do @ panopticlick.eff.org
    @ga_user = user_by_ga
    if @ga_user.last_visit
      @last_visit = @ga_user.last_visit
    end
    @ga_user.last_visit = Time.now
    @ga_user.save
    
    @fingerprint = Fingerprint.find_or_create_by(browser_fingerprint.merge(request_fingerprint))
    @fingerprint_user = user_by_fingerprint(@fingerprint)
    if @fingerprint_user.last_visit
      @fingerprint_last_visit = @fingerprint_user.last_visit
      @fingerprint_user.hits += 1
    end
    @fingerprint_user.last_visit = Time.now 
    @fingerprint_user.save
    
    respond_to do |format|
      format.html { render @fingerprint_user, notice: "Successfully identified user by fingerprint." }
      format.json { render :json => {
          :fingerprint_user => @fingerprint_user, 
          :ga_user => @ga_user, 
          :fingerprint => @fingerprint
        }, 
        status: :created, 
        head: :ok, 
        location: @fingerprint_user
      }
    end
    
  end

  private
  def google_tags
    {
      # TODO: the first one might not fit -> may be session-specific name?
      gat_gtag_UA_158940829_2: cookies[:_gat_gtag_UA_158940829_2],
      ga: cookies[:_ga],
      gid: cookies[:_gid]
    }
  end

  def browser_fingerprint
    params.require(:fingerprint).permit(Fingerprint.column_names)
  end
  def request_fingerprint
    {
      user_agent: request.user_agent,
      # TODO: not sure where the accept text/html header is
      accept_headers: request.headers[:accept],
      accept_encoding: request.headers["accept-encoding"],
      accept_language: request.headers["accept-language"],
      cookies_enabled: !request.cookies.blank?,
    }
  end
  
  def user_by_ga
    if google_tags[:ga]
      user = User.find_or_create_by(ga: google_tags[:ga])
      if user.last_visit
        user.hits += 1
      end
      return user
    else 
      return User.new
    end
  end

  def user_by_fingerprint(fingerprint)
    if fingerprint.user
      return fingerprint.user 
    end

    related_fingerprint = fingerprint.guess_other_fingerprint
    if related_fingerprint
      fingerprint.user = related_fingerprint.user 
      fingerprint.save
      return related_fingerprint.user 
    end

    fingerprint.user = User.create()
    fingerprint.save
    return fingerprint.user
  end

end