class Order < ApplicationRecord
  belongs_to :user
  has_many :product_lists
  before_create :generate_token
  validates_presence_of :billing_name,:billing_address,:shipping_name,:shipping_address
  def generate_token
    self.token=SecureRandom.uuid
  end
end