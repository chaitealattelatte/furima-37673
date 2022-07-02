require 'rails_helper'

RSpec.describe Purchaser, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchaser = FactoryBot.build(:purchasers_order, user_id: @user.id, item_id: @item.id)
    sleep(0.1)
  end

  describe '商品購入機能' do
    context '内容に問題ない場合' do
      it 'post_code,source_id,city,address,building,phoneが存在すれば登録できる' do
        expect(@purchaser).to be_valid
      end
      it 'buildingが存在しなくても登録できる' do
        @purchaser.building = ''
        expect(@purchaser).to be_valid
      end
    end
  end

  context '内容に問題がある場合' do
    it 'post_codeが空では登録できない' do
      @purchaser.post_code = ''
      @purchaser.valid?
      expect(@purchaser.errors.full_messages).to include("Post code can't be blank", 'Post code is invalid. Include hyphen(-)')
    end
    it 'post_codeにハイフンが入っていなければ登録できない' do
      @purchaser.post_code = '0001111'
      @purchaser.valid?
      expect(@purchaser.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
    end
    it 'post_codeに全角数字が入っていたら登録できない' do
      @purchaser.post_code = '０００-１１１１'
      @purchaser.valid?
      expect(@purchaser.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
    end
    it 'source_idが1では登録できない' do
      @purchaser.source_id = 1
      @purchaser.valid?
      expect(@purchaser.errors.full_messages).to include("Source can't be blank")
    end
    it 'cityが空では登録できない' do
      @purchaser.city = ''
      @purchaser.valid?
      expect(@purchaser.errors.full_messages).to include("City can't be blank")
    end
    it 'addressが空では登録できない' do
      @purchaser.address = ''
      @purchaser.valid?
      expect(@purchaser.errors.full_messages).to include("Address can't be blank")
    end
    it 'phoneが空では登録できない' do
      @purchaser.phone = ''
      @purchaser.valid?
      expect(@purchaser.errors.full_messages).to include("Phone can't be blank", 'Phone は半角数値のみ登録可能です')
    end
    it 'phoneに全角数字が入っていたら登録できない' do
      @purchaser.phone = '０００１１１１２２２２'
      @purchaser.valid?
      expect(@purchaser.errors.full_messages).to include('Phone は半角数値のみ登録可能です')
    end
    it 'phoneにハイフンが入っていたら登録できない' do
      @purchaser.phone = '000-0000-0000'
      @purchaser.valid?
      expect(@purchaser.errors.full_messages).to include('Phone は半角数値のみ登録可能です')
    end
    it 'phoneにローマ字が入っていたら登録できない' do
      @purchaser.phone = 'aaabbbbcccc'
      @purchaser.valid?
      expect(@purchaser.errors.full_messages).to include('Phone は半角数値のみ登録可能です')
    end
    it 'phoneが9桁以下だったら登録できない' do
      @purchaser.phone = '123456789'
      @purchaser.valid?
      expect(@purchaser.errors.full_messages).to include('Phone は半角数値のみ登録可能です')
    end
    it 'phoneが12桁以上だったら登録できない' do
      @purchaser.phone = '123456789101112'
      @purchaser.valid?
      expect(@purchaser.errors.full_messages).to include('Phone は半角数値のみ登録可能です')
    end
  end
end
