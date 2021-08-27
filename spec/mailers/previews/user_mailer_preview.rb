# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def welcome_email
    user = User.last
    UserMailer.welcome_email(user)
  end

  def welcome_broker
    user = User.last
    UserMailer.welcome_broker(user)
  end

  def broker_approved
    user = User.last
    UserMailer.broker_approved(user)
  end
end
