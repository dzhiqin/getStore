class WelcomeController < ApplicationController
  def index
    # flash[:alert]="alert!"
    @products=Product.all.order("id ASC").limit(4)
  end
  layout "welcome"
end
