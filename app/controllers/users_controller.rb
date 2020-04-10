class UsersController < ApplicationController
  def index
    # byebug
    render :index
  end

  private
  def google_tags
    {
      _gat_gtag_UA_158940829_2: cookies[:_gat_gtag_UA_158940829_2],
      _ga: cookies[:ga],
      _gid: cookies[:_gid]
    }
  end
end