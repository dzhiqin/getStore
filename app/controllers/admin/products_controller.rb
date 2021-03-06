class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  layout "admin"
  def index
    @products=Product.all
  end
  def new
    @product=Product.new
  end
  def show
    @product=Product.find(params[:id])
  end
  def edit
    @product=Product.find(params[:id])
  end
  def create
    @product=Product.new(product_params)
    if @product.save
      redirect_to admin_products_path
      flash[:notice]="success"
    else
      render :new
      flash[:alert]="failed"
    end
  end
  def update
    @product=Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end
  def destroy
    @product=Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
    flash[:alert]="已经删除"
  end
  protected
  def product_params
    params.require(:product).permit(:title,:description,:price,:quantity,:product_img,:lesson_img,:pgimg,:brif_desc,:category_id,:remove_lesson_img,:remove_pgimg,{:lesson_img=>[]},{:pgimg=> []})
  end

end
