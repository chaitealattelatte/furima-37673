class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :charge
  belongs_to :source
  belongs_to :delivery_day
  belongs_to :user
  has_one_attached :image
  has_one :order

  with_options presence: true do
    validates :image, blob: { content_type: :image }
    validates :name
    validates :description
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :category_id, :condition_id, :charge_id, :source_id, :delivery_day_id,
              numericality: { other_than: 1, message: "can't be blank" }
  end
end
