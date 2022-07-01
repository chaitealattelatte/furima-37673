class Order < ApplicationRecord
  has_one :purchaser
  belongs_to :item
  belongs_to :user
end
