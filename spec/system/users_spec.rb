require 'rails_helper'

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end


RSpec.describe "Users", type: :system do
  before do 
    @user = FactoryBot.build(:user) 
  end 

  context 'ログアウト状態の挙動' do
    it 'ログアウト状態の場合には、トップページ（商品一覧ページ）のヘッダーに、「新規登録」「ログイン」ボタンが表示されること' do
      #basic認証クリア
      basic_pass(root_path)

      ### トップページ内に「新規登録」「ログイン」ボタンがある
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
    end

    it 'トップページ（商品一覧ページ）ヘッダーの、「新規登録」ボタンをクリックすると、遷移できること。' do #「トップページ（商品一覧ページ）ヘッダーの、「新規登録」「ログイン」ボタンをクリックすると、各ページに遷移できること。」のテスト
      #basic認証クリア
      basic_pass(root_path)
      # トップページ内の「新規登録」ボタンをクリックする
      click_on '新規登録'
      #新規登録ページに遷移できたことを確かめる
      expect(current_path).to eq(new_user_registration_path)
    end
    it 'トップページ（商品一覧ページ）ヘッダーの、「ログイン」ボタンをクリックすると、遷移できること。' do#「トップページ（商品一覧ページ）ヘッダーの、「新規登録」「ログイン」ボタンをクリックすると、各ページに遷移できること。」のテスト
      #basic認証クリア
      basic_pass(root_path)
      # トップページ内の「新規登録」ボタンをクリックする
      click_on 'ログイン'
      #新規登録ページに遷移できたことを確かめる
      expect(current_path).to eq(new_user_session_path)
    end
  end

  context 'ログイン時の挙動' do
    it 'ログイン状態の場合には、トップページ（商品一覧ページ）のヘッダーに、「ユーザーのニックネーム」と「ログアウト」ボタンが表示されること。' do
      #予めFactoryBotで作った@userをこのテストコード実行中だけDBに登録したような状態にする（新規登録を済ませておくイメージ）
      @user = FactoryBot.create(:user)
      #basic認証クリア
      basic_pass(root_path)
      #トップページ内の「ログイン」ボタンをクリック
      click_link 'ログイン'
      # ログインページに遷移したことを確認
      expect(page).to have_current_path(new_user_session_path)
      ### ログインフォームにメールアドレスとパスワードを入力する
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      # ログインボタンをクリックする（フォームを送信する）
      click_on 'ログイン'
      # ログイン後のページに遷移したことを確認
      expect(page).to have_current_path(root_path)
      # トップページ内に「ユーザーのニックネーム」「ログアウト」ボタンがある
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('ログアウト')
    end
    it 'トップページ（商品一覧ページ）ヘッダーの、「ログアウト」ボタンをクリックすると、ログアウトができること。' do
      #予めFactoryBotで作った@userをこのテストコード実行中だけDBに登録したような状態にする（新規登録を済ませておくイメージ）
      @user = FactoryBot.create(:user)
      #basic認証クリア
      basic_pass(root_path)
      #トップページ内の「ログイン」ボタンをクリック
      click_link 'ログイン'
      # ログインページに遷移したことを確認
      expect(page).to have_current_path(new_user_session_path)
      ### ログインフォームにメールアドレスとパスワードを入力する
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      # ログインボタンをクリックする（フォームを送信する）
      click_on 'ログイン'
      # トップページ内の「ログアウト」ボタンをクリック
      click_on 'ログアウト'
      expect(current_path).to eq(root_path)
    end
  end
end