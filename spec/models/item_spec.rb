require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

describe '商品出品機能' do
  context '内容に問題ない場合' do
    it "name,description,price,category_id,condition_id,charge_id,source_id,
    delivery_day_id,user_id,imageが存在すれば登録できる" do
      expect(@item).to be_valid
    end
   end

  context '内容に問題がある場合' do
    it "nameが空では登録できない" do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end
    it "descriptionが空では登録できない" do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end
    it "category_idが1では登録できない" do
      @item.category_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end
    it "condition_idが1では登録できない" do
      @item.condition_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Condition can't be blank")
    end
    it "charge_idが1では登録できない" do
      @item.charge_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Charge can't be blank")
    end
    it "source_idが1では登録できない" do
      @item.source_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Source can't be blank")
    end
    it "delivery_day_idが1では登録できない" do
      @item.delivery_day_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery day can't be blank")
    end
    it "priceが空では登録できない" do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it "priceが300円未満では出品できない" do
      @item.price = 100
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end
    it "priceが9_999_999円を超えると出品できない" do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
    end
    it "priceに半角数字以外が入力された場合登録できない" do
      @item.price = '１０００'
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end
     it "imageが空では登録できない" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
     end
     it "userが紐付いていなければ出品できない" do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
     end

  end
 end
end