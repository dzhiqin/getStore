class ProductsController < ApplicationController
  before_action :authenticate_user!,only:[:like,:unlike]
  def index
    @products=Product.all
  end

  def show
    @product=Product.find(params[:id])
    @posts=@product.posts
  end
  def add_to_cart
    @product=Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice]="add to cart success"
    else
      flash[:alert]="already added"
    end
    redirect_to :back
  end
  def like
    @product=Product.find(params[:id])
    if current_user.like?(@product)
      flash[:notice]="已经收藏过商品"
      redirect_to :back
    else
      current_user.like!(@product)
      redirect_to :back
      flash[:notice]="收藏成功"
    end

  end
  def unlike
    @product=Product.find(params[:id])
    if !current_user.like?(@product)
      flash[:notice]="还未收藏过商品"
      redirect_to :back
    else
      current_user.unlike!(@product)
      redirect_to :back
      flash[:notice]="取消收藏"
    end
  end

  private

end
