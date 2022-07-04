Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials.dig(:google_oauth2, :client_id), Rails.application.credentials.dig(:google_oauth2, :client_secret)
  provider :intuit, Rails.application.credentials.dig(:intuit, :client_id), Rails.application.credentials.dig(:intuit, :client_secret), scope: 'openid email profile'
end
