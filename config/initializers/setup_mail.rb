ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :server               =>  'smtp.sendgrid.net',
  :ports                =>  '587',
  :username             =>  'apikey',
  :password             =>  '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'
}


# 25, 587	(for unencrypted/TLS connections)
# 465	(for SSL connections)