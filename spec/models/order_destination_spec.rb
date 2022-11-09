require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  describe '配送先情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_destination = FactoryBot.build(:order_destination, user_id: @user.id, item_id: @item.id)
    end

      context '内容に問題ない場合' do
        it 'すべての値が正しく入力されていれば購入できること' do
          expect(@order_destination).to be_valid
        end
        it '建物名は空でも購入できること' do
          @order_destination.building = ''
          expect(@order_destination).to be_valid
        end
       end
  
      context '内容に問題がある場合' do
        it '郵便番号が空だと購入できないこと' do
          @order_destination.postal_code = ''
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("郵便番号を入力してください")
        end
        it '郵便番号が「3桁ハイフン4桁」の半角文字列以外は購入できないこと' do
          @order_destination.postal_code = '1234567'
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include('郵便番号を「3桁ハイフン4桁」の半角文字を入力してください')
        end
        it '都道府県が初期値だと購入できないこと' do
          @order_destination.prefecture_id = 1
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("都道府県を入力してください")
        end
        it '市区町村が空だと購入できないこと' do
          @order_destination.city = ''
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("市区町村を入力してください")
        end
        it '番地が空だと購入できないこと' do
          @order_destination.address = ''
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("番地を入力してください")
        end
        it '電話番号が空だと購入できないこと' do
          @order_destination.phone_number = ''
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("電話番号を入力してください")
        end
        it '電話番号が9桁以下では購入できないこと' do
          @order_destination.phone_number = '090123456'
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("電話番号を「10桁以上、11桁以内」の半角数字を入力してください")
        end
        it '電話番号が12桁以上では購入できないこと' do
          @order_destination.phone_number = '090123456789'
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("電話番号を「10桁以上、11桁以内」の半角数字を入力してください")
        end
        it '電話番号に半角数字以外が含まれている場合は購入できないこと' do
          @order_destination.phone_number = '09012345abc'
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("電話番号を「10桁以上、11桁以内」の半角数字を入力してください")
        end
        it 'ユーザーが紐付いていないと購入できないこと' do
          @order_destination.user_id = nil
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("ユーザーを入力してください")
        end
        it 'アイテムが紐付いていないと購入できないこと' do
          @order_destination.item_id = nil
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("アイテムを入力してください")
        end
        it "クレジットカード情報が空では購入できないこと" do
          @order_destination.token = nil
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("クレジットカード情報を入力してください")
        end
      end
  end
end
