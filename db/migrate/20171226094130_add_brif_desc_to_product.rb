class AddBrifDescToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products,:brif_desc,:string
  end
end
