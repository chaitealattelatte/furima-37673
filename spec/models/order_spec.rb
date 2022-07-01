require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.create(:order)
    sleep(1)
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
        expect(@order.errors.full_messages).to include('Item must exist')
      end
      it 'userが紐付いていなければ保存できない' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include('User must exist')
      end
    end
  end
end
