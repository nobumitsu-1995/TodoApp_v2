require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "ユーザー登録した後ログアウトし、再びログインする。" do
    visit root_path
    expect{
      click_link "新規登録"
      fill_in "名前", with: "テスト"
      fill_in "メールアドレス", with: "test@test.com"
      fill_in "パスワード", with: "test"
      click_button "登録する"

      expect(page).to have_content "ユーザーを新規作成しました。"
      expect(page).to have_content "TODO LIST"
    }.to change(User, :count).by(1)

    click_link "ログアウト"
    click_link "ログイン"

    fill_in "メールアドレス", with: "test@test.com"
    fill_in "パスワード", with: "test"
    click_button "ログイン"

    expect(page).to have_content "ログインしました。"
  end

  scenario "ログイン後ユーザー情報を編集し、再ログインする。" do
    user = FactoryBot.create(:user)

    visit root_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    click_link "#{user.name}"
    click_link "Edit"

    fill_in "名前", with: "テスト"
    fill_in "メールアドレス", with: "test@test.com"
    fill_in "パスワード", with: "test"
    click_button "更新する"

    expect(page).to have_content "ユーザー情報を更新しました。"

    click_link "ログアウト"
    expect(page).to have_content "ログアウトしました。"

    click_link "ログイン"
    fill_in "メールアドレス", with: "test@test.com"
    fill_in "パスワード", with: "test"
    click_button "ログイン"

    expect(page).to have_content "ログインしました。"
  end

  scenario "誤ったログイン情報の時、ログインできない。", js: true do
    user = FactoryBot.create(:user, name: "test", email: "test", password: "test")

    visit root_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "hoge"
    click_button "ログイン"

    expect(page).to have_content "ログインに失敗しました。"
  end
end
