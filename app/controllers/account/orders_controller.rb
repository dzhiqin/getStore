class Account::OrdersController < ApplicationController
  before_action :authenticate_user!
  layout "mylayout"
  def index
    @orders=current_user.orders.order("id DESC")
  end
  def destroy
    @order=Order.find_by_token(params[:id])
    @order.destroy
    redirect_to account_orders_path
    flash[:alert]="成功删除订单"
  end
end
