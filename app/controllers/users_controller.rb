class UsersController < ApplicationController
  def index
    authorize
  end
  def new
    flash[:notice] = "your shopping site is one click away"
    @user=User.new
  end
  def show
    authorize
    flash[:notice] = ""
    if @user[:id].to_s !=""
      render action: 'show'
    else
      flash[:notice] = "Please login with your email & password"
      render action: 'index'
    end
  end
  
  def login
    if User.exists?(:email => user_params[:email],:password =>user_params[:password])
      reset_session
      @user = User.find_by(email: user_params[:email])
      session[:email]=@user[:email]
      session[:password]=@user[:password]
      session[:id]=@user[:id]
      flash[:notice] = ""
      redirect_to url_for(@user)
    else
      @user=User.new(user_params)
      flash[:notice] = "Error! wrong email/password, please try again"
      render action: 'index'
    end    
  end
  
  def logout
    session[:id]=""
    session[:email]=""
    session[:password]=""
    reset_session
    session.clear
    redirect_to "/"
  end
  
  def create
    if User.exists?(:email => user_params[:email])
        @user = User.new(user_params)
        flash[:notice] = "Error! User already exists, please try different"
        render action: 'new'
    else
      @user = User.new(user_params)
      if @user.save
        session[:email]=@user[:email]
        session[:password]=@user[:password]
        flash[:notice] = "Congrats! "+@user[:name]+" , check your site with email & password"
        render action: 'index'
      else
        flash[:notice] = "Error! Something went wrong, please try again"
        render action: 'new'
      end
    end
  end
  
  #site
  
  def newsite
    @site=Site.new
  end
  
  def addsite
    authorize
    if User.site.exists?(:alias => site_params[:alias])
      flash[:notice] = "Error! Site already exists, please try different"
      render action: 'new'
    else
      @site = User.site.create(site_params)
      #getUser
      #@site.user=@user
      if @site.save
        redirect_to users_url,:notice=>"Congrats! Your site is added"
      else
        flash[:notice] = "Error! Something went wrong, please try again"
        render action: 'new'
      end
    end    
  end
  
  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:confirm_password)
  end
  def site_params
    params.require(:site).permit(:alias,:title,:description)
  end
  def authorize
    if !User.exists?(:email => session[:email],:password => session[:password], :id => session[:id])
        @user=User.new
        flash[:notice] = "Please login with your email & password"
    else
      @user = User.find_by(id: session[:id])
    end
  end
end