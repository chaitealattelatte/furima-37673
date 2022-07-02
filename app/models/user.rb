class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :family_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]/ }
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]/ }
    validates :kana_family, format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :kana_first, format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :date_of_birth

    VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数を両方含む必要があります' }
  end

  has_many :items
  has_many :orders
end
