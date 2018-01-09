class AddPgimgToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :pgimg, :json
  end
end
