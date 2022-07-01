class Purchaser < ApplicationRecord
  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :source_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone, format: { with: /\A\d{10,11}\z/, message: 'は半角数値のみ登録可能です' }
  end

  belongs_to :order
end
