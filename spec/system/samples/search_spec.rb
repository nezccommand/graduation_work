require "rails_helper"

RSpec.describe "実例一覧・検索画面", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "実例一覧表示" do
    let!(:samples) { create_list(:sample, 3) }

    it "実例一覧が表示される" do
      visit samples_path

      samples.each do |sample|
        expect(page).to have_content(sample.title)
        expect(page).to have_content(sample.short_description)
        expect(page).to have_link("詳しく見る", href: sample_path(sample))
      end

      expect(page).not_to have_content("該当する実例はありません")
    end

    it "『詳しく見る』リンクを押すと実例の詳細ページに遷移する" do
      visit samples_path
      sample = samples.first

      expect(page).to have_link("詳しく見る", href: sample_path(sample))

      click_link "詳しく見る", href: sample_path(sample)

      expect(page).to have_current_path(sample_path(sample))
      expect(page).to have_content(sample.title)
    end
  end

  describe "検索結果表示" do
    let!(:target_sample) { create(:sample, title: "特別なキーワードを含むタイトル") }
    let!(:other_sample) { create(:sample, title: "別のタイトル") }

    it "検索条件なしでアクセスした場合、全ての実例が表示される" do
      visit samples_path

      expect(page).to have_content("実例一覧")
      expect(page).to have_content(target_sample.title)
      expect(page).to have_content(other_sample.title)
    end

    it "検索キーワードに合致する実例のみ表示される" do
      visit samples_path(q: { title_or_sample_text_cont: "特別なキーワード" })

      expect(page).to have_content("検索結果")
      expect(page).to have_content(target_sample.title)
      expect(page).not_to have_content(other_sample.title)
      expect(page).not_to have_content("該当する実例はありません")
    end

    it "検索結果が0件の場合は該当なしメッセージが表示される" do
      visit samples_path(q: { title_or_sample_text_cont: "存在しないキーワード" })

      expect(page).to have_content("検索結果")
      expect(page).to have_content("該当する実例はありません")
    end
  end

  it "タグリンクをクリックすると該当タグの検索結果ページに遷移し、関連する実例が表示される" do
    tag = create(:tag, name: "パスワード")
    sample = create(:sample)
    sample.tags << tag

    visit sample_path(sample)

    expect(page).to have_link("パスワード", href: samples_path(q: { tags_name_eq: "パスワード" }))

    click_link "パスワード"

    expect(page).to have_current_path(samples_path(q: { tags_name_eq: "パスワード" }))
    expect(page).to have_content("検索結果")
    expect(page).to have_content(sample.title)
  end
end
