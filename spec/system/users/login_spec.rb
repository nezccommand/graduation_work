require "rails_helper"

RSpec.describe "ユーザーログイン", type: :system do
  before do
    driven_by :rack_test
  end
  let(:user) { create(:user, email: "test@example.com", password: "password") }

  it "トップページからログインページに遷移し、正しい情報でログインできる" do
    visit root_path
      within("main") do
    click_link "ログイン"
  end

    expect(page).to have_current_path(new_user_session_path)

    fill_in "メールアドレス", with: user.email
    fill_in "パスワード(6文字以上)", with: "password"
    click_button "ログイン"

    expect(page).to have_content("ログインしました")
    expect(page).to have_current_path(root_path) 
    expect(page).to have_content(user.name)
  end

  it "ログイン後にログインリンクが消える" do
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード(6文字以上)", with: "password"
    click_button "ログイン"

    expect(page).not_to have_link("ログイン")
    expect(page).to have_link("ログアウト")
  end

  it "ログアウトボタンでログアウトできる", js: true do
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード(6文字以上)", with: "password"
    click_button "ログイン"

    expect(page).to have_content("ログインしました")

    within("main") do
      click_link "ログアウト"
    end

    expect(page).to have_content("ログアウトしました")
    expect(page).to have_link("ログイン")
  end

  it "間違ったメールアドレスではログインできない" do
    visit new_user_session_path
    fill_in "メールアドレス", with: "wrong@example.com"
    fill_in "パスワード(6文字以上)", with: "password"
    click_button "ログイン"

    expect(page).to have_content("ユーザーが見つかりません")
    expect(page).to have_current_path(new_user_session_path)
  end

  it "未ログイン時にログインが必要なページにアクセスするとメッセージが表示される" do
    visit "/simulation_email/new"

    expect(page).to have_content("ログインもしくはアカウント登録してください。")
    expect(current_path).to eq(new_user_session_path)
  end
end