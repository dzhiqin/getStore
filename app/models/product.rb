class Product < ApplicationRecord
  mount_uploader :product_img, ProductImgUploader
  has_many :cart_items
  mount_uploaders :lesson_img,LessonImageUploader
  serialize :lesson_img,JSON
  has_many :favorites
  has_many :favorited_users,:through=> :favorites,:source=> :users
  has_many :posts
  belongs_to :category 
end
