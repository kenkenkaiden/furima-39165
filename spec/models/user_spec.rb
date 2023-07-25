require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @user = FactoryBot.build(:user) 
  end 

  describe 'ユーザー新規登録' do
    context '新規登録ができる場合' do
      it "nicknameとemail、passwordとpassword_confirmation、family_name、first_name、family_name_kana、first_name_kana、birthdayの全てが適切に入力されている" do
      expect(@user).to be_valid
      end
    end

    context '新規登録ができない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = "" 
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = "" 
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "重複したemailが存在する場合は登録できない" do 
        @user.save
        another_user = FactoryBot.build(:user) 
        another_user.email = @user.email 
        another_user.valid? 
        expect(another_user.errors.full_messages).to include('Email has already been taken') 
      end
      it 'emailに@が含まれていなかったら登録できない' do
        @user.email = "testyahoo.com" 
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが空では登録できない' do
        @user.password = "" 
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = "abcd1" 
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)') 
      end
      it 'passwordに全角文字が含まれていると登録できない' do #「パスワードは、半角英数字混合での入力が必須であること」のテスト
        @user.password = "Ａbc123" 
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字混合で入力してください')
      end
      it 'passwordが半角アルファベットだけでは登録できない' do #「パスワードは、半角英数字混合での入力が必須であること」のテスト
        @user.password = "abcdef" 
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字混合で入力してください') #「パスワードは、半角英数字混合での入力が必須であること」のテスト
      end
      it 'passwordが半角数字だけでは登録できない' do
        @user.password = "123456" 
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字混合で入力してください')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'family_nameが空では登録できない' do
        @user.family_name = "" 
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = "" 
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'family_nameで全角のアルファベット及び半角文字が使われていると登録できない' do # 「お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること」のテスト
        @user.family_name = "Ａa1ｱ" 
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name は全角（漢字・ひらがな・カタカナ）で入力してください")
      end
      it 'first_nameで全角のアルファベット及び半角文字が使われていると登録できない' do # 「お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること」のテスト
        @user.first_name = "Ａa1ｱ" 
        @user.valid?
        expect(@user.errors.full_messages).to include("First name は全角（漢字・ひらがな・カタカナ）で入力してください")
      end
      it 'family_name_kanaが空では登録できない' do
        @user.family_name_kana = "" 
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = "" 
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'family_name_kanaで全角カタカナ以外の文字が使われていると登録できない' do # 「お名前カナ(全角)は、全角（カタカナ）での入力が必須であること」のテスト
        @user.family_name_kana = "Ａa1ｱあ亜" 
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana は全角（カタカナ）で入力してください")
      end
      it 'first_name_kanaで全角カタカナ以外の文字が使われていると登録できない' do # 「お名前カナ(全角)は、全角（カタカナ）での入力が必須であること」のテスト
        @user.first_name_kana = "Ａa1ｱあ亜" 
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana は全角（カタカナ）で入力してください")
      end
      it 'birthdayが空だと登録できない' do
        @user = FactoryBot.build(:user, birthday: nil)
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end

  

end



#新規登録/ユーザー情報



#新規登録/本人情報確認

#トップページ
# ログアウト状態の場合には、トップページ（商品一覧ページ）のヘッダーに、「新規登録」「ログイン」ボタンが表示されること。
# ログイン状態の場合には、トップページ（商品一覧ページ）のヘッダーに、「ユーザーのニックネーム」と「ログアウト」ボタンが表示されること。
# トップページ（商品一覧ページ）ヘッダーの、「新規登録」「ログイン」ボタンをクリックすると、各ページに遷移できること。
# トップページ（商品一覧ページ）ヘッダーの、「ログアウト」ボタンをクリックすると、ログアウトができること。