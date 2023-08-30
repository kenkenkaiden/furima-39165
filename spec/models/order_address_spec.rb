require 'rails_helper' 
RSpec.describe OrderAddress, type: :model do
  before do 

    @order_address = FactoryBot.build(:order_address) 
  end 

  describe '商品購入における配送先情報の入力' do
    context '商品購入ができる場合' do
      it "postal_code(郵便番号)とprefecture_id(都道府県)、city(市区町村)、street_address(番地)、building_name(建物の名前)、phone_number(電話番号)が適切に入力されている" do
        expect(@order_address).to be_valid
      end

      it "入力欄のうちbuilding_name(建物の名前)のみが空でも購入できる" do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '商品購入ができない場合' do
      it "postal_code(郵便番号)が空では購入できない" do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it "postal_code(郵便番号)に3桁ハイフン4桁の半角文字列以外が入力されても購入できない" do
        @order_address.postal_code = '11-2222'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it "prefecture_id(都道府県)が空では購入できない" do
        @order_address.prefecture_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it "city(市区町村)が空では購入できない" do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it "street_address(番地)が空では購入できない" do
        @order_address.street_address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Street address can't be blank")
      end

      it "phone_number(電話番号)が空では購入できない" do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it "phone_number(電話番号)が10～11桁以外では購入できない" do
        @order_address.phone_number = '123-456-7890'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number は、10桁以上11桁以内の半角数値で入力してください。")
      end
    end
  end
end
