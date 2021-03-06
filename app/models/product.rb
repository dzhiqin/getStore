class Product < ApplicationRecord
  validates_presence_of :title,:quantity,:price
  mount_uploader :product_img, ProductImgUploader
  has_many :cart_items
  mount_uploaders :lesson_img,LessonImageUploader
  serialize :lesson_img,JSON
  has_many :favorites
  has_many :favorited_users,:through=> :favorites,:source=> :users
  has_many :posts
  belongs_to :category
  mount_uploaders :pgimg ,PgimgUploader
  # STATUS=["全部","文学","经济","社科","家庭","艺术","心理","商业"]
  def is_empty?
    self.quantity > 0
  end
end
