class Product < ApplicationRecord
  mount_uploader :product_img, ProductImgUploader
  has_many :cart_items
  mount_uploaders :lesson_img,LessonImageUploader
  serialize :lesson_img,JSON
end
