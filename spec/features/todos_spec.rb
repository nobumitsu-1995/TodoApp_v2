require 'rails_helper'

RSpec.feature "Todos", type: :feature do
  scenario "ユーザーは新しいTodoを作成する。" do
    user = FactoryBot.create(:user)

    visit root_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    expect{
      click_link "新規todoを作成"
      fill_in "内容", with: "test"
      click_button "登録する"

      expect(page).to have_content "作成しました。"
      expect(page).to have_content "TODO LIST"
    }.to change(user.todos, :count).by(1)
  end

  scenario "Todoを完了済みにし未完了に戻す。", js: true do
    user = FactoryBot.create(:user)
    todo = FactoryBot.create(:todo, user: user)

    visit root_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    click_link "#{todo.content}"
    accept_confirm do
      click_link "完了"
    end
    expect(page).to have_content "Todoを完了しました。"

    accept_confirm do
      click_link "未完了に戻す"
    end
    expect(page).to have_content "Todoを未完了に戻しました。"
    expect(todo.status).to eq("on_going")
  end

  scenario "Todoを削除する。", js: true do
    user = FactoryBot.create(:user)
    todo = FactoryBot.create(:todo, user: user)

    visit root_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    expect{
      click_link "#{todo.content}"
      accept_confirm do
        click_link "削除"
      end

      expect(page).to have_content "削除しました。"
      expect(page).to have_content "TODO LIST"
    }.to change(user.todos, :count).by(-1)
  end

  scenario "Todoを編集する。" do
    user = FactoryBot.create(:user)
    todo = FactoryBot.create(:todo, user: user)

    visit root_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    click_link "#{todo.content}"
    click_link "編集"

    fill_in "内容", with: "testtesttest"
    click_button "更新する"

    expect(page).to have_content "testtesttest"
  end
end
