class PurchasersOrder
  include ActiveModel::Model
  attr_accessor :post_code, :source_id, :city, :address,
                :building, :phone, :order_id, :item_id, :user_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :source_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone, format: { with: /\A\d{10,11}\z/, message: 'は半角数値のみ登録可能です' }
    validates :item_id
    validates :user_id
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Purchaser.create(post_code: post_code, source_id: source_id, city: city,
                     address: address, building: building, phone: phone, order_id: order.id)
  end
end
