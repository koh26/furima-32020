require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '必要な情報が記載されていれば登録できる' do
        expect(@user).to be_valid
      end

      it 'メールアドレスは@が含まれていて登録されていないものであれば登録できる' do
        @user.email = 'aaa@aaa'
        expect(@user).to be_valid
      end

      it 'パスワードは半角英数字混合、6文字以上,2回入力(確認をあわせて),両パスワード一致で登録できる' do
        @user.password = 'a11111'
        @user.password_confirmation = 'a11111'
        expect(@user).to be_valid
      end

      it 'last_nameは全角（漢字・ひらがな・カタカナ）で登録できる' do
        @user.last_name = '山だダヨ'
        expect(@user).to be_valid
      end

      it 'first_nameは全角（漢字・ひらがな・カタカナ）で登録できる' do
        @user.first_name = '太ろウ'
        expect(@user).to be_valid
      end

      it 'k_last_nameは全角（カタカナ）で登録できる' do
        @user.k_last_name = 'ヤマダ'
        expect(@user).to be_valid
      end

      it 'k_first_nameは全角（カタカナ）で登録できる' do
        @user.k_first_name = 'タロウ'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", "Password confirmation doesn't match Password")
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'k_last_nameが空では登録できない' do
        @user.k_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("K last name can't be blank")
      end

      it 'k_first_nameが空では登録できない' do
        @user.k_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("K first name can't be blank")
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      it '@が含まれていないとemailは登録できない' do
        @user.email = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'すでに登録されているemailは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'パスワードは5文字以下で登録できない' do
        @user.password = 'a1111'
        @user.password_confirmation = 'a1111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードは半角英数字混合での入力が必要' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", 'Password is invalid')
      end

      it 'パスワードは確認用を含めて2回入力しなければいけない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'パスワードとパスワード(確認用)、の値が一致していなければいけない' do
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'ユーザー本名(名字)は全角（漢字・ひらがな・カタカナ）の入力が必要' do
        @user.last_name = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end

      it 'ユーザー本名(名前)は全角（漢字・ひらがな・カタカナ）の入力が必要' do
        @user.first_name = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'フリガナユーザー本名(名字)は全角（カタカナ）での入力が必要' do
        @user.k_last_name = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('K last name is invalid')
      end

      it 'フリガナユーザー本名(名前)は全角（カタカナ）での入力が必要' do
        @user.k_first_name = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('K first name is invalid')
      end
    end
  end
end
