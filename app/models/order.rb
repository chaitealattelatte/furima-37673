class Order < ApplicationRecord
  attr_accessor :token

  has_one :purchaser
  belongs_to :item
  belongs_to :user
end
