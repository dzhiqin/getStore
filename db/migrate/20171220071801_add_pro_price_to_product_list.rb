class AddProPriceToProductList < ActiveRecord::Migration[5.0]
  def change
    add_column :product_lists,:pro_price,:integer,default:0
  end
end
