require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'アソシエーション' do
    it { is_expected.to have_many(:quiz_histories).dependent(:destroy) }
    it { is_expected.to have_many(:email_logs).dependent(:destroy) }
    it { is_expected.to have_many(:user_badges).dependent(:destroy) }
    it { is_expected.to have_many(:badges).through(:user_badges) }
  end

  describe 'バリデーション' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(255) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    it 'メール形式が正しい必要がある' do
      invalid_user = build(:user, email: 'invalid_email')
      expect(invalid_user).to be_invalid
      expect(invalid_user.errors[:email]).to include("は正しい形式で入力してください")
    end

    context 'パスワードのバリデーション（通常ユーザー）' do
      it '6文字未満は無効' do
        user = build(:user, password: '123', password_confirmation: '123')
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end

      it 'パスワード確認が一致しないと無効' do
        user = build(:user, password: 'password', password_confirmation: 'different')
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).to include("と一致しません")
      end
    end

    context 'OAuthユーザーの場合' do
      it 'パスワードバリデーションが無効になる' do
        user = build(:user, :google_user)
        expect(user).to be_valid
      end
    end

    it '同じproviderかつuidは一意でなければならない' do
      create(:user, :google_user, email: 'a@example.com')
      duplicate_user = build(:user, :google_user, email: 'b@example.com')
      expect(duplicate_user).to be_invalid
      expect(duplicate_user.errors[:uid]).to include("はすでに使用されています")
    end
  end
end
