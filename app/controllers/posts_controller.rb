class PostsController < ApplicationController
  before_action :authenticate_user!,only:[:new,:create]
  def index
    @posts=Post.all
  end
  def new
    @post=Post.new
  end
  def create
    @product=Product.find(params[:product_id])
    @post=Post.new(post_params)
    @post.user=current_user
    @post.product=@product
    if @post.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end
  private
  def post_params
    params.require(:post).permit(:content)
  end
end
