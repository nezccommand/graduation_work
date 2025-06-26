class User < ApplicationRecord
  has_many :quiz_histories, dependent: :destroy
  has_many :email_logs, dependent: :destroy

  def oauth_user?
    provider.present? && uid.present?
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :confirmable,
          :omniauthable, omniauth_providers: %i[google_oauth2]

  validates :uid, uniqueness: { scope: :provider }
  validates :password, length: { minimum: 6 }, if: -> { !oauth_user? && (new_record? || changes[:encrypted_password]) }
  validates :password, confirmation: true, if: -> { !oauth_user? && (new_record? || changes[:encrypted_password]) }
  validates :password_confirmation, presence: true, if: -> { !oauth_user? && (new_record? || changes[:encrypted_password]) }
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  def email_logs_sent_today_count
    email_logs.where(sent_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count
  end

  def can_send_phishing_email?
    email_logs_sent_today_count < 5
  end

  def remaining_email_sends(limit = 5)
    [ limit - email_logs_sent_today_count, 0 ].max
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name.presence || auth.info.email.split("@").first
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end
end
