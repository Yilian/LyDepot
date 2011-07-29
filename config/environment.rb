# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Depot::Application.initialize!

=begin
Depot::Application.configure do
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address        => "smtp.gmail.com",
    :port           => 587,
    :domain         => "gmail.com",
    :authentication => "plain",
    :user_name      => "PragmaticStore",
    :password       => "web123456",
    :enable_starttls_auto => true
  }
end
=end
