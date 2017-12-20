class OrderMailer < ApplicationMailer
  def notify_order_placed(order)
    @order=order
    @user=order.user
    @product_lists=@order.product_lists
    mail(to:@user.email,subject:"GetStore 感谢您完成本次下单，以下是您此次购物明细#{order.token}")
  end
  def apply_cancel(order)
    @order=order
    @user=order.user
    @product_lists=@order.product_lists
    mail(to:"admin@test.com",subject:"GetStore 用户#{order.user.email}申请取消订单#{order.token}")
  end
  def nofity_ship(order)
    @order=order
    @user=order.user
    @product_lists=@order.product_lists
    mail(to: @user.email,subject:"[GetStore]您的订单#{order.token}已发货")
  end
  def nofity_cancel(order)
    @order=order
    @user=order.user
    @product_lists=@order.product_lists
    mail(to: @user.email,subjet:"[GetStore] 您的订单#{order.token}已取消")
  end
end
