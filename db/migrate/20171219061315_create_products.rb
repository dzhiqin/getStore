class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :quantity
      t.integer :price
      t.string :product_img
      t.string :lesson_img

      t.timestamps
    end
  end
end
