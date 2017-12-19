class Product < ApplicationRecord
  mount_uploader :product_img, ProductImgUploader
  has_many :cart_items
  
end
