require "rails_helper"

RSpec.describe "ヘッダー", type: :system do
  let(:user) { create(:user, confirmed_at: Time.current) }

  before do
    driven_by(:rack_test)
  end

  context "ログイン前" do
    before { visit root_path }

    describe "ヘッダーのリンク" do
      it "ホームへのリンクが存在する" do
        within("header") do
          expect(page).to have_link("フィッシング詐欺学習室", href: root_path)
        end
      end

      it "ログインページへのリンクが存在する" do
        within("header") do
          expect(page).to have_link("ログイン", href: new_user_session_path)
        end
      end

      it "クイズページへのリンクが存在する" do
        within("header") do
          expect(page).to have_link("クイズ", href: select_quizzes_path)
        end
      end

      it "実例一覧ページへのリンクが存在する" do
        within("header") do
          expect(page).to have_link("実例一覧", href: samples_path)
        end
      end
    end

    describe "各リンクから遷移できるか" do
      it "クイズページに遷移できる" do
        click_link "クイズ"
        expect(page).to have_current_path(select_quizzes_path)
      end

      it "実例一覧ページに遷移できる" do
        click_link "実例一覧"
        expect(page).to have_current_path(samples_path)
      end

      it "ログインページに遷移できる" do
        click_link "ログイン", match: :first
        expect(page).to have_current_path(new_user_session_path)
      end

      it "ホームリンクでトップに戻れる" do
        visit samples_path
        click_link "フィッシング詐欺学習室", match: :first
        expect(page).to have_current_path(root_path)
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

    it "クイズと実例一覧に遷移できる" do
      visit root_path

      within("header") do
        expect(page).to have_link("クイズ", href: select_quizzes_path)
        expect(page).to have_link("実例一覧", href: samples_path)
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
