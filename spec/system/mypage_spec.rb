require 'rails_helper'

RSpec.describe "マイページ表示", type: :system do
  let(:user) { create(:user) }
  let!(:quiz_history) { create(:quiz_history, user: user, correct_count: 8, total_count: 10, difficulty: "easy", genre: "基本知識") }



  before do
    driven_by(:rack_test)
    ActionMailer::Base.deliveries.clear
  end

  it "未ログイン時にアクセスするとメッセージが表示される" do
    visit mypage_path

    expect(page).to have_content("ログインもしくはアカウント登録してください。")
    expect(current_path).to eq(new_user_session_path)
  end

  it "ログイン時にアクセスできる" do
    login_as(user, scope: :user)
    visit mypage_path

    expect(current_path).to eq("/mypage")
    expect(page).to have_content("マイページ")
  end

  it "クイズ履歴が表示される" do
    login_as(user, scope: :user)
    visit mypage_path

    expect(page).to have_content("10問中8問正解")
    expect(page).to have_content("Easy ・基本知識")
  end
end
