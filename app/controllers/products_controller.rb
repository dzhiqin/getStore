class ProductsController < ApplicationController
  before_action :authenticate_user!,only:[:like,:unlike]
  def index
    if params[:select_id].present?
      @value_id=params[:select_id]
      @products=Product.where(:category_id=>params[:select_id])
    else
      @products=Product.all
    end
    @order_state=params[:order_state]
    @products = case params[:order_state]
    when '价格从低到高'
      @products.order('price ASC')

    when '价格从高到低'
      @products.order('price DESC')
    else
      @products
    end
  end


  def show
    @product=Product.find(params[:id])
    @posts=@product.posts.includes(:votes).order("votes_count DESC")

  end
  def add_to_cart
    @product=Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice]="成功添加到购物车！"
    else
      flash[:alert]="已经添加到购物车！"
    end
    redirect_to :back
  end
  def cart_and_buy
    @product=Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)

    end
    redirect_to carts_path
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

  def update
    @product=Product.find(params[:id])
    @product.update(product_params)
    binding.pry
    render :json=>{:id=>@product.id,:message=>"ok"}
  end
  private
  def product_params
    params.require(:post).permit(:content,:category_id,:select_id)
  end
end
