Devise.setup do |config|
  config.jwt do |jwt|
    jwt.secret = '1607d5b65bcf381c6619605fa1e832bc485ad5c78267de8d659de8d304fa70455ecc36b41fa0c2527cda586d844bd0f8c301934ee6d6e86c82822b2b9b8b793f' #ENV['DEVISE_JWT_SECRET_KEY']
    jwt.dispatch_requests = [
        ['POST', %r{^/login$}]
    ]
    jwt.revocation_requests = [
        ['DELETE', %r{^/logout$}]
    ]
    jwt.expiration_time = 30.day.to_i
  end
  config.navigational_formats = []
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
