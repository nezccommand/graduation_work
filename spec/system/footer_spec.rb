require "rails_helper"

RSpec.describe "フッター", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "フッターに『利用規約』リンクが表示され、正しく遷移する" do
    visit root_path

    within("footer") do
      expect(page).to have_link("利用規約", href: terms_path)
      click_link "利用規約"
    end
    expect(current_path).to eq terms_path
  end

  it "フッターに『プライバシーポリシー』リンクが表示され、正しく遷移する" do
    visit root_path

    within("footer") do
      expect(page).to have_link("プライバシーポリシー", href: privacy_policy_path)
      click_link "プライバシーポリシー"
    end
    expect(current_path).to eq privacy_policy_path
  end

  it "フッターに『お問い合わせ』リンクが表示されている" do
    visit root_path

    within("footer") do
      expect(page).to have_link(
        "お問い合わせ",
        href: "https://docs.google.com/forms/d/e/1FAIpQLSfq8ZzVVvBEnwfvdPKBL1qomJXDGgd_feVILxeXgxqFh4fmEw/viewform?usp=dialog"
      )
    end
  end

  it "フッターに注意書きが表示されている" do
    visit root_path

    within("footer") do
      expect(page).to have_text(
        "本サイトに掲載されているフィッシングメールは、実在の企業・団体を装った詐欺の例です。当該企業・団体はこれらの詐欺に一切関与していません。"
      )
    end
  end
end
