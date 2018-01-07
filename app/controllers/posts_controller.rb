class PostsController < ApplicationController
  before_action :authenticate_user!,only:[:destroy,:create,:vote,:unvote]
  layout "mylayout"
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
      # redirect_to product_path(@product)

      flash[:notice]="发表成功"
    else

      flash[:alert]="发表失败"

    end
  end
  def destroy
    @product=Product.find(params[:product_id])
    @post=Post.find(params[:id])
      if @post.destroy
        # redirect_to :back
        # render :js=>"alert('ok')"
        flash[:notice]="删除成功"
      else
        flash[:alert]="删除失败"
        redirect_to :back
      end
  end
  def vote
    @product=Product.find(params[:product_id])
    @post=Post.find(params[:id])
    if current_user.voted?(@post)
      # redirect_to :back
      flash[:alert]="已支持"
    else
      current_user.vote!(@post)
      # redirect_to :back
      flash[:notice]="支持"
    end
  end

  def unvote
    @product=Product.find(params[:product_id])
    @post=Post.find(params[:id])
    if current_user.voted?(@post)
      current_user.unvote!(@post)
      # redirect_to :back
      render :vote
      flash[:notice]="取消支持"
    else
      render :vote
      # redirect_to :back
      flash[:alert]="没有支持过"
    end
  end
  private
  def post_params
    params.require(:post).permit(:content)
  end
end
