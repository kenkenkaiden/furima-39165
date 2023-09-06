require 'rails_helper'
RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入における配送先情報の入力' do
    context '商品購入ができる場合' do
      it 'tokenが生成され(=クレジットカード情報が全て適切に入力され)、postal_code(郵便番号)とprefecture_id(都道府県)、city(市区町村)、street_address(番地)、building_name(建物の名前)、phone_number(電話番号)が適切に入力されている' do
        expect(@order_address).to be_valid
      end

      it '入力欄のうちbuilding_name(建物の名前)のみが空でも購入できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '商品購入ができない場合' do
      it 'tokenが空では購入できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'postal_code(郵便番号)が空では購入できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_code(郵便番号)に3桁ハイフン4桁の半角文字列以外が入力されても購入できない' do
        @order_address.postal_code = '11-2222'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'prefecture_id(都道府県)が空では購入できない' do
        @order_address.prefecture = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'prefecture_id(都道府県)の選択肢が"---"では購入できない' do
        @order_address.prefecture = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'city(市区町村)が空では購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it 'street_address(番地)が空では購入できない' do
        @order_address.street_address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Street address can't be blank")
      end

      it 'phone_number(電話番号)が空では購入できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_number(電話番号)が9桁以下では購入できない' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number は、10桁以上11桁以内の半角数値で入力してください。')
      end

      it 'phone_number(電話番号)が12桁以上では購入できない' do
        @order_address.phone_number = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number は、10桁以上11桁以内の半角数値で入力してください。')
      end

      it 'phone_number(電話番号)に半角数字以外が含まれている場合は購入できない' do
        @order_address.phone_number = '123-456-7890'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number は、10桁以上11桁以内の半角数値で入力してください。')
      end

      it 'userが紐づいていなければ場合は購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐づいていなければ場合は購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
