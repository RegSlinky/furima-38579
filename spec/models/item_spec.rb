require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end


  describe '商品の出品' do
    context "商品が保存できる場合" do
      it "すべての値が正しく入力されていれば商品は保存される" do
        expect(@item).to be_valid
      end
    end
    context '商品が保存できないとき' do
      it '商品名が空では保存できない' do
        @item.item = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it '画像が空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it '商品の説明が空では保存できない' do
        @item.item_text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'カテゴリーの情報が初期値では保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end
      it '商品の状態が初期値では保存できない' do
        @item.sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end
      it '配送料の負担の情報が初期値では保存できない' do
        @item.shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end
      it '発送元の地域の情報が初期値では保存できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end 
      it '発送までの日数の情報が初期値では保存できない' do
        @item.schedule_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end
      it '価格が空では保存できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end
      it '価格が半角数値以外は保存できない' do
        @item.price = 'あああ'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を¥300~¥9,999,999の間の半角数字を入力してください")
      end
      it '価格が¥300以下では保存できない' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を¥300~¥9,999,999の間の半角数字を入力してください")
      end
      it '価格が¥9,999,999以上では保存できない' do
        @item.price = 90000000
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を¥300~¥9,999,999の間の半角数字を入力してください")
      end
      it 'ユーザー情報がない場合は保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("ユーザーを入力してください")
      end
    end
  end
end

