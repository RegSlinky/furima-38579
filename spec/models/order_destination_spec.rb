require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  describe '配送先情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_destination = FactoryBot.build(:order_destination, user_id: @user.id, item_id: @item.id)
    end

      context '内容に問題ない場合' do
        it 'すべての値が正しく入力されていれば保存できること' do
          expect(@order_destination).to be_valid
        end
        it '建物名は空でも保存できること' do
          @order_destination.building = ''
          expect(@order_destination).to be_valid
        end
       end
  
      context '内容に問題がある場合' do
        it '郵便番号が空だと保存できないこと' do
          @order_destination.postal_code = ''
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("Postal code can't be blank")
        end
        it '郵便番号が「3桁ハイフン4桁」の半角文字列以外は保存できないこと' do
          @order_destination.postal_code = '1234567'
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
        end
        it '都道府県が初期値だと保存できないこと' do
          @order_destination.prefecture_id = 1
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("Prefecture can't be blank")
        end
        it '市区町村が空だと保存できないこと' do
          @order_destination.city = ''
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("City can't be blank")
        end
        it '番地が空だと保存できないこと' do
          @order_destination.address = ''
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("Address can't be blank")
        end
        it '電話番号が空だと保存できないこと' do
          @order_destination.phone_number = ''
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("Phone number can't be blank")
        end
        it '電話番号が10桁以上11桁以内の半角数値以外だと保存できないこと' do
          @order_destination.phone_number = '090123'
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("Phone number is invalid")
        end
        it 'userが紐付いていないと保存できないこと' do
          @order_destination.user_id = nil
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("User can't be blank")
        end
        it 'itemが紐付いていないと保存できないこと' do
          @order_destination.item_id = nil
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("Item can't be blank")
        end
      end
  end
end
