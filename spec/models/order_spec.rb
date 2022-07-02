require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order = FactoryBot.build(:purchasers_order, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入機能' do
    context '内容に問題ない場合' do
      it 'itemとuserが紐付いていれば保存できる' do
        expect(@order).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'itemが紐付いていなければ保存できない' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Item can't be blank")
      end
      it 'userが紐付いていなければ保存できない' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
