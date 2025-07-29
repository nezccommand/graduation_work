require "rails_helper"

RSpec.describe "ヘッダー", type: :system do
  let(:user) { create(:user, confirmed_at: Time.current) }

  before do
    driven_by(:rack_test)
  end

  context "ログイン前" do
    it "ホームへのリンクが存在する" do
      visit root_path

      within("header") do
        expect(page).to have_link("フィッシング詐欺学習室", href: root_path)
        expect(page).to have_link("ログイン", href: new_user_session_path)
      end
    end
  end

  context "ログイン後" do
    before do
      login_as(user, scope: :user)
    end

    it "ホームアイコンでトップに戻れる" do
      visit "/quizzes/select"

      within("header") do
        find("a[aria-label='ホーム']").click
      end

      expect(current_path).to eq(root_path)
    end

    it "メニューが存在する" do
      visit root_path

      within("header") do
        expect(page).to have_selector("#menu-button")
        find("#menu-button").click
        expect(page).to have_content("ログアウト")
      end
    end

    it "ログアウトできる" do
      visit root_path

      within("header") do
        find("#menu-button").click
        click_link "ログアウト", match: :first
      end

      expect(page).to have_content("ログアウトしました")
      expect(current_path).to eq(root_path)
    end
  end
end
