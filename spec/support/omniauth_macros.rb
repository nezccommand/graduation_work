module OmniauthMacros
  def mock_auth_hash
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123545',
      info: {
        email: 'test@example.com',
        name: 'Test User'
      }
    })
  end
end