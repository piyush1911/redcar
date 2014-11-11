class ProductsController < ApplicationController
  def create
    authorize
    authorize_site
    @product=Product.new(product_params)
    if Product.exists?(:alias => product_params[:alias],:site_id=>@site[:id])
      flash[:notice] = "Product already exists, try adding new one"
      render action: 'new'
    else
      @product[:user_id]=@user[:id]
      @product[:site_id]=@site[:id]
      if @product.save
        flash[:notice] = "Congrats! Product added successfully"
        redirect_to url_for(@site),:notice=>"Congrats! Product added successfully"
      else
      flash[:notice] = "Oops!! Something went wrong, please try again"
      render action: 'new'
      end
    end
  end
  def new
    authorize
    authorize_site
    @product=Product.new
    @product[:site_id]=@site[:id]
  end
  private
  def product_params
    params.require(:product).permit(:alias,:title,:description, :price)
  end
  def authorize
    if !User.exists?(:email => session[:email],:password => session[:password],:id => session[:id])
      session.clear
      reset_session
      flash[:notice] = "Please login"
      redirect_to "/"
    else
      @user = User.find_by(id: session[:id])
    end
  end
  def authorize_site
    if !@user.sites.exists?(:alias => params[:site_alias])
      session.clear
      reset_session
      flash[:notice] = "Please login"
      redirect_to "/"
    else
      @site=Site.find_by(alias: params[:site_alias])
    end
  end
end
