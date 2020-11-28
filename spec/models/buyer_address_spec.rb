require 'rails_helper'

RSpec.describe BuyerAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @buyer_address = FactoryBot.build(:buyer_address, user_id: @user.id, item_id: @item.id)
  end

  describe '購入者情報の保存' do
    context '購入者情報の保存がうまくいくとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@buyer_address).to be_valid
      end
    end

    context '購入者情報の保存がうまくいかないとき' do
      it '郵便番号が空だと保存できないこと' do
        @buyer_address.postal_code = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Postal code can't be blank", 'Postal code is invalid. Include hyphen(-)')
      end

      it 'prefecture_idが1だと保存できないこと' do
        @buyer_address.prefecture_id = 1
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('Prefecture must be other than 1')
      end

      it '市町村が空だと保存できないこと' do
        @buyer_address.city = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空だと保存できないこと' do
        @buyer_address.number = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Number can't be blank")
      end

      it '電話番号が空だと保存できないこと' do
        @buyer_address.tel = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Tel can't be blank")
      end

      it '郵便番号にはハイフンがなければ保存できない' do
        @buyer_address.postal_code = 1_234_567
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '電話番号に-が入っていると保存できないこと' do
        @buyer_address.tel = '090-7852-5875'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('Tel is invalid')
      end

      it 'tokenが空だと保存できないこと' do
        @buyer_address.token = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
