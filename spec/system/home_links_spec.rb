require "rails_helper"

RSpec.describe "トップページのリンク表示", type: :system do
  let(:user) { create(:user) }

  before do
    driven_by(:rack_test)
  end

  context "未ログイン時" do
    it "クイズやサンプル、ログイン・新規登録ボタンが表示される" do
      visit root_path

      expect(page).to have_link("クイズを始める")
      expect(page).to have_link("実例一覧を見る")
      expect(page).to have_link("ログイン")
      expect(page).to have_link("新規登録")

      expect(page).not_to have_link("模擬メールを送る")
      expect(page).not_to have_link("ログアウト")
    end
  end

  context "ログイン時" do
    before do
      login_as(user, scope: :user)
    end

    it "クイズやサンプル、模擬メール・ログアウトが表示される" do
      visit root_path

      expect(page).to have_link("クイズを始める")
      expect(page).to have_link("実例一覧を見る")
      expect(page).to have_link("模擬メールを送る")
      expect(page).to have_link("ログアウト")

      expect(page).not_to have_link("ログイン")
      expect(page).not_to have_link("新規登録")
    end
  end
end
