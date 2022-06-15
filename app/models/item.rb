class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :charge, :source, :user
  has_one_attached :image
  
  validates :image, presence: true, blob:{content_type: :image }

  validates :name, :description, presence: true
  validates :price, inclusion: { in: 300..9999999, message: 'は¥300~¥9,999,999の間のみ入力可能です'},
  numericality: { with: /^[0-9]+$/ , message: 'は半角数字のみ入力可能です'}, presence: true

  validates :category_id, :condition_id, :charge_id, :source_id, :delivery_day_id, numericality: { other_than: 1 , message: "can't be blank"} 
end
