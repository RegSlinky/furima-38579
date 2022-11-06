require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end


  describe '商品の出品' do
    context "商品が保存できる場合" do
      it "商品名と商品の説明、画像と価格、カテゴリーの情報、商品の状態、配送料の負担の情報、発送までの日数の情報、発送元の地域の情報があれば商品は保存される" do
        expect(@item).to be_valid
      end
    end
    context '商品が保存できないとき' do
      it '商品名が空では保存できない' do
        @item.item = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item can't be blank")
      end
      it '画像が空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品の説明が空では保存できない' do
        @item.item_text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item text can't be blank")
      end
      it 'カテゴリーの情報が初期値では保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態が初期値では保存できない' do
        @item.sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales status can't be blank")
      end
      it '配送料の負担の情報が初期値では保存できない' do
        @item.shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
      end
      it '発送元の地域の情報が初期値では保存できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end 
      it '発送までの日数の情報が初期値では保存できない' do
        @item.schedule_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Schedule delivery can't be blank")
      end
      it '価格が空では保存できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が半角数値以外は保存できない' do
        @item.price = 'あああ'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end
      it '価格が¥300以下では保存できない' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end
      it '価格が¥9,999,999以上では保存できない' do
        @item.price = 90000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end
      it 'ユーザー情報がない場合は保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end

