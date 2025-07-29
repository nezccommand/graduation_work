# spec/system/simulation_email_spec.rb
require 'rails_helper'


RSpec.describe "模擬メール送信機能", type: :system do

  let(:user) { create(:user) }

  before do
    driven_by(:rack_test)
    ActionMailer::Base.deliveries.clear
  end

  it "未ログイン時にアクセスするとメッセージが表示される" do
    visit new_simulation_email_path

    expect(page).to have_content("ログインもしくはアカウント登録してください。")
    expect(current_path).to eq(new_user_session_path)
  end

  it "ログイン時にアクセスできる" do
    sign_in user

    visit "/simulation_email/new"

    expect(current_path).to eq("/simulation_email/new")
    expect(page).to have_content("以下のメールアドレスに模擬フィッシングメールを送信します")
  end

  it "模擬メールが送信される" do
    sign_in user
    visit new_simulation_email_path

    click_button "模擬メールを送信する"
    expect(ActionMailer::Base.deliveries.count).to eq 1

    mail = ActionMailer::Base.deliveries.last
    expect(mail.to).to include("test@example.com")
    expect(mail.subject).to include("模擬フィッシングメール")
    expect(mail.body.encoded).to include("模擬フィッシング訓練")
  end

  it "メール送信時に EmailLog が作成される" do
    sign_in user
    visit new_simulation_email_path

    expect {
      click_button "模擬メールを送信する"
    }.to change { EmailLog.count }.by(1)

    email_log = EmailLog.last
    expect(email_log.user).to eq user
    expect(email_log.sent_at.to_date).to eq Time.zone.today
  end
end
