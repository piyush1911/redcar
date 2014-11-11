class SitesController < ApplicationController
  def index
    flash[:notice] = ""
    reset_session
    session.clear
    @sites=Site.all
  end
  def show
    getSite
    getUser
    @is_user_site_owner = @site.user[:id].to_s == @user[:id].to_s
    if @is_user_site_owner
      flash[:notice]="you owned this site"
    else
      flash[:notice] = ""
    end
  end
  def new
    authorize
    @site=Site.new
  end
  def create
    authorize
    if Site.exists?(:alias => site_params[:alias],:user_id => session[:id])
      @site=Site.new
      flash[:notice] = "Error! Site already exists, please try different"
      render action: 'new'
    else
      @site = Site.new(site_params)
      getUser
      @site.user=@user
      if @site.save
        redirect_to url_for(@user),:notice=>"Congrats! Your site is added"
      else
        flash[:notice] = "Error! Something went wrong, please try again"
        render action: 'new'
      end
    end
  end
  private
  def site_params
    params.require(:site).permit(:alias,:title,:description)
  end
  def authorize
    if !User.exists?(:email => session[:email],:password => session[:password],:id => session[:id])
        flash[:notice] = "Please login"
        redirect_to users_login_url,:notice=>"Please login"
    end
  end 
  def getUser
    @user = User.find_by(id: session[:id])
    if @user == nil
      @user=User.new(:id=>0,:name=>"guest")
    end
  end
  def getSite
    @site = Site.find_by(:id=>params[:id])
  end
end
