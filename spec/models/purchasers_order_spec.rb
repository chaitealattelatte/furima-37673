require 'rails_helper'

RSpec.describe PurchasersOrder, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchasers_order = FactoryBot.build(:purchasers_order, user_id: @user.id, item_id: @item.id)
    sleep(0.1)
  end

  describe '商品購入機能' do
    context '内容に問題ない場合' do
      it 'post_code,source_id,city,address,building,phone,user_id,item_idが存在すれば登録できる' do
        expect(@purchasers_order).to be_valid
      end
      it 'buildingが存在しなくても登録できる' do
        @purchasers_order.building = ''
        expect(@purchasers_order).to be_valid
      end
    end
  end

  context '内容に問題がある場合' do
    it 'post_codeが空では登録できない' do
      @purchasers_order.post_code = ''
      @purchasers_order.valid?
      expect(@purchasers_order.errors.full_messages).to include("Post code can't be blank",
                                                                'Post code is invalid. Include hyphen(-)')
    end
    it 'post_codeにハイフンが入っていなければ登録できない' do
      @purchasers_order.post_code = '0001111'
      @purchasers_order.valid?
      expect(@purchasers_order.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
    end
    it 'post_codeに全角数字が入っていたら登録できない' do
      @purchasers_order.post_code = '０００-１１１１'
      @purchasers_order.valid?
      expect(@purchasers_order.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
    end
    it 'source_idが1では登録できない' do
      @purchasers_order.source_id = 1
      @purchasers_order.valid?
      expect(@purchasers_order.errors.full_messages).to include("Source can't be blank")
    end
    it 'cityが空では登録できない' do
      @purchasers_order.city = ''
      @purchasers_order.valid?
      expect(@purchasers_order.errors.full_messages).to include("City can't be blank")
    end
    it 'addressが空では登録できない' do
      @purchasers_order.address = ''
      @purchasers_order.valid?
      expect(@purchasers_order.errors.full_messages).to include("Address can't be blank")
    end
    it 'phoneが空では登録できない' do
      @purchasers_order.phone = ''
      @purchasers_order.valid?
      expect(@purchasers_order.errors.full_messages).to include("Phone can't be blank", 'Phone は半角数値のみ登録可能です')
    end
    it 'phoneに全角数字が入っていたら登録できない' do
      @purchasers_order.phone = '０００１１１１２２２２'
      @purchasers_order.valid?
      expect(@purchasers_order.errors.full_messages).to include('Phone は半角数値のみ登録可能です')
    end
    it 'phoneにハイフンが入っていたら登録できない' do
      @purchasers_order.phone = '000-0000-0000'
      @purchasers_order.valid?
      expect(@purchasers_order.errors.full_messages).to include('Phone は半角数値のみ登録可能です')
    end
    it 'phoneにローマ字が入っていたら登録できない' do
      @purchasers_order.phone = 'aaabbbbcccc'
      @purchasers_order.valid?
      expect(@purchasers_order.errors.full_messages).to include('Phone は半角数値のみ登録可能です')
    end
    it 'phoneが9桁以下だったら登録できない' do
      @purchasers_order.phone = '123456789'
      @purchasers_order.valid?
      expect(@purchasers_order.errors.full_messages).to include('Phone は半角数値のみ登録可能です')
    end
    it 'phoneが12桁以上だったら登録できない' do
      @purchasers_order.phone = '123456789101112'
      @purchasers_order.valid?
      expect(@purchasers_order.errors.full_messages).to include('Phone は半角数値のみ登録可能です')
    end
    it 'itemが紐付いていないと保存できないこと' do
      @purchasers_order.item_id = nil
      @purchasers_order.valid?
      expect(@purchasers_order.errors.full_messages).to include("Item can't be blank")
    end
    it 'userが紐付いていないと保存できないこと' do
      @purchasers_order.user_id = nil
      @purchasers_order.valid?
      expect(@purchasers_order.errors.full_messages).to include("User can't be blank")
    end
    it 'tokenが空では保存できないこと' do
      @purchasers_order.token = nil
      @purchasers_order.valid?
      expect(@purchasers_order.errors.full_messages).to include("Token can't be blank")
    end
  end
end
