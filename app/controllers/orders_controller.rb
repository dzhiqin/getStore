class OrdersController < ApplicationController
  before_action :authenticate_user! ,only:[:create]
  layout "mylayout"
  def create

    @order=Order.new(order_params)
    @order.user=current_user
    @order.total=current_cart.total_price
    if @order.save
      current_cart.cart_items.each do |cart_item|
        product_list=ProductList.new
        product_list.order=@order
        product_list.product_name=cart_item.product.title
        product_list.pro_price=cart_item.product.price
        product_list.quantity=cart_item.quantity
        product_list.save
      end
      current_cart.clean!
      OrderMailer.notify_order_placed(@order).deliver!
      redirect_to order_path(@order.token)
    else
      render "carts/checkout"
    end
  end

  def show

    @order=Order.find_by_token(params[:id])
    @product_lists=@order.product_lists
  end
  def pay_with_weixin
    @order=Order.find_by_token(params[:id])
    @order.set_payment_with!("weixin")
    update_quantity
    # redirect_to order_path(@order.token),notice:"使用微信完成付款"

  end
  def pay_with_alipay
    @order=Order.find_by_token(params[:id])
    @order.set_payment_with!("alipay")
    # 付款后产品数量相应减少
    update_quantity
    # redirect_to order_path(@order.token),notice:"使用支付宝完成付款"

  end
  def apply_to_cancel
    @order=Order.find(params[:id])
    OrderMailer.apply_cancel(@order).deliver!
    flash[:notice]="已提交申请"
    redirect_to :back
  end
  private
  def order_params
    params.require(:order).permit(:billing_name,:billing_address,:shipping_name,:shipping_address)
  end
  def update_quantity

    @order.product_lists.each do |product_list|
      @product=Product.find_by_title(product_list.product_name)
      if @product.quantity >= product_list.quantity
        @product.update(:quantity=>(@product.quantity-product_list.quantity))
        redirect_to order_path(@order.token)
        @order.make_payment!
        flash[:notice]="使用#{(@order.payment_method=="alipay")? "支付宝":"微信"}完成付款"
      else
        flash[:alert]="库存不足"
        redirect_to :back
      end
    end
  end
end
