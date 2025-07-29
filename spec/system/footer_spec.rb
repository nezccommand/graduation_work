require "rails_helper"

RSpec.describe "フッター", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "フッターにリンクと注意書きが表示されている" do
    visit root_path

    within("footer") do
      expect(page).to have_link("© 2025 フィッシング詐欺学習室 -それ、ホンモノですか？-")
      expect(page).to have_link("利用規約", href: terms_path)
      expect(page).to have_link("プライバシーポリシー", href: privacy_policy_path)
      expect(page).to have_link("お問い合わせ", href: "https://docs.google.com/forms/d/e/1FAIpQLSfq8ZzVVvBEnwfvdPKBL1qomJXDGgd_feVILxeXgxqFh4fmEw/viewform?usp=dialog")
      expect(page).to have_text("本サイトに掲載されているフィッシングメールは、実在の企業・団体を装った詐欺の例です。当該企業・団体はこれらの詐欺に一切関与していません。")
    end
  end
end
