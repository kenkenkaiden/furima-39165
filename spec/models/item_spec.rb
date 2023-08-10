require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の新規出品' do
    context '新規出品ができる場合' do
      it 'name、description、category、condition、shipping_method、prefecture、days_to_ship、priceの全てが適切に入力されている' do
        expect(@item).to be_valid
      end
    end
    context '新規出品ができない場合' do
      it '商品画像（:image）を1枚つけることが必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名（:name）が必須であること' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明（:description）の説明が必須であること' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリー（:category_id）の情報が必須であること' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'カテゴリー（:category_id）で初期値の「---」を選ぶと出品できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態（:condition_id）の情報が必須であること' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '商品の状態（:condition_id）で初期値の「---」を選ぶと出品できないこと' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '配送料の負担（:shipping_method_id）の情報が必須であること' do
        @item.shipping_method_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping method can't be blank")
      end
      it '配送料の負担（:shipping_method_id）で初期値の「---」を選ぶと出品できないこと' do
        @item.shipping_method_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping method can't be blank")
      end
      it '発送元の地域（:prefecture_id）の情報が必須であること' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送元の地域（:prefecture_id）で初期値の「---」を選ぶと出品できないこと' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '価格の情報（:price）の情報が必須であること' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格（:price）は、¥300~¥9,999,999の間のみ保存可能であること(¥299以下のチェック)' do
        @item.price = Faker::Number.between(to: 299)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は¥300〜¥9,999,999の間の半角数値で入力してください')
      end
      it '価格（:price）は、¥300~¥9,999,999の間のみ保存可能であること(¥10,000,000以上のチェック )' do
        @item.price = Faker::Number.between(from: 10_000_000)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は¥300〜¥9,999,999の間の半角数値で入力してください')
      end
      it '価格（:price）は半角数値のみ保存可能であること' do
        @item.price = '１２３４５６'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は¥300〜¥9,999,999の間の半角数値で入力してください')
      end
      it 'ユーザー（:user）が紐付いていなければ出品できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
