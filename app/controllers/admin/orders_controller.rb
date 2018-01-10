class Admin::OrdersController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :require_admin
  def index
    @orders=Order.order("id DESC").page(params[:page]).per(20)
  end
  def show
    @order=Order.find(params[:id])
    @product_lists=@order.product_lists
  end
  def ship
    @order=Order.find(params[:id])
    @order.ship!
    OrderMailer.notify_ship(@order).deliver!
    # OrderMailer.notify_ship(@order).deliver!
    redirect_to :back
  end
  def shipped
    @order=Order.find(params[:id])
    @order.deliver!
    redirect_to :back
  end
  def cancel
    @order=Order.find(params[:id])
    @order.cancel_order!
    OrderMailer.notify_cancel(@order).deliver!
    # OrderMailer.notify_cancel(@order).deliver!
    update_quantity
    redirect_to :back
  end
  def return
    @order=Order.find(params[:id])
    @order.return_good!
    redirect_to :back
  end
  def destroy
    @order=Order.find(params[:id])
    @order.destroy
    flash[:alert]="已删除"
    redirect_to admin_orders_path
  end
  private
  def update_quantity
    #只有当付过款的才需要更新数量
    if @order.is_paid
      @order.product_lists.each do |product_list|
        @product=Product.find_by_title(product_list.product_name)
        @product.update(:quantity=>@product.quantity+product_list.quantity)
      end
    end
  end
end
