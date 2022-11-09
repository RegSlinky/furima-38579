require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべての値が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'Eメールが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it '名字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください")
      end
      it '名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it '名字(カナ)が空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字(カナ)を入力してください")
      end
      it '名前(カナ)が空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)を入力してください")
      end
      it '生年月日が空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
      it '重複したEメールが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'Eメールは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'パスワードが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'パスワードが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは128文字以内で入力してください")
      end
      it 'パスワードとパスワード(確認)が不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it '英字のみのパスワードでは登録できない' do
          @user.password = 'abcdef'
          @user.password_confirmation = 'abcdef'
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワードを英字と数字の両方を含めて入力してください")
      end
      it '数字のみのパスワードでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを英字と数字の両方を含めて入力してください")
      end
      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'abcd5６'
        @user.password_confirmation = 'abcd5６'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを英字と数字の両方を含めて入力してください")
      end
      it '名字は、全角（漢字・ひらがな・カタカナ）入力でなければ登録できないこと' do
        @user.last_name = "yamada"
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を全角で入力してください")
      end
      it '名前は、全角（漢字・ひらがな・カタカナ）入力でなければ登録できないこと' do
        @user.first_name = "taro"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を全角で入力してください")
      end
      it '名字(カナ)は、全角（カタカナ）入力でなければ登録できないこと' do
        @user.last_name_kana = "やまだ"
        @user.valid?
        expect(@user.errors.full_messages).to include("名字(カナ)を全角カタカナで入力してください")
      end
      it '名前(カナ)は、全角（カタカナ）入力でなければ登録できないこと' do
        @user.first_name_kana = "たろう"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)を全角カタカナで入力してください")
      end
    end
  end
end

