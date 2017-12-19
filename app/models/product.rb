class Product < ApplicationRecord
  mount_uploader :product_img, ProductImgUploader
end
