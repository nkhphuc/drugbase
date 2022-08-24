ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              =>  'smtp.sendgrid.net',
  :port                 =>  '587',
  # :authentication       =>  :plain,
  :user_name            =>  'apikey',
  :password             =>  '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',
  # :domain               =>  'heroku.com',
  # :enable_starttls_auto  =>  true
}


# 25, 587	(for unencrypted/TLS connections)
# 465	(for SSL connections)