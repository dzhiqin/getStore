class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def admin?
    is_admin
  end
  has_many :orders
  has_many :favorites
  has_many :favorite_products, :through=> :favorites,:source=> :product
  has_many :posts
  has_many :votes
  has_many :voted_posts,:through=>:votes,:source=>:post
  def like?(product)
    self.favorite_products.include?(product)
  end
  def like!(product)
    self.favorite_products << product
  end
  def unlike!(product)
    self.favorite_products.delete(product)
  end

  def voted?(post)
    self.voted_posts.include?(post)
  end
  def vote!(post)
    self.voted_posts << post
  end
  def unvote!(post)
    self.voted_posts.delete(post)
  end
end
