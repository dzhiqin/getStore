class Post < ApplicationRecord
  has_many :votes
  validates_presence_of :content
  belongs_to :user
  belongs_to :product
end
