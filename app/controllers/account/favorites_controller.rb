class Account::FavoritesController < ApplicationController
  before_action :authenticate_user!
  layout "mylayout"
  def index
    @products=current_user.favorite_products
  end
  
end
