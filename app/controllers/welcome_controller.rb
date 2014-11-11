class WelcomeController < ApplicationController
  def index
    flash[:notice] = ""
    reset_session
    session.clear
    @sites=Site.all
  end
end