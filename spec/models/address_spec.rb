require 'rails_helper'
RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.build(:address)
  end

  describe '商品購入における配送先情報の入力' do
    context '商品購入ができる場合' do
      it 'postal_code(郵便番号)とprefecture_id(都道府県)、city(市町村)、street_address(番地)、building_name(建物の名前)、phone_number(電話番号)が適切に入力されている' do
        expect(@address).to be_valid
      end
    end

    context '商品購入ができない場合' do
    end
  end
end

# 郵便番号が必須であること。
# 郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（良い例：123-4567　良くない例：1234567）。
# 都道府県が必須であること。
# 市区町村が必須であること。
# 番地が必須であること。
# 建物名は任意であること。
# 電話番号が必須であること。
# 電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（良い例：09012345678　良くない例：090-1234-5678）。
