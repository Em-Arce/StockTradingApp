class UserMailer < ApplicationMailer
  default from: 'railsnewappnotificationaug2021@gmail.com'
  layout 'mailer'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to StockTradingApp')
  end

  def welcome_broker(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to StockTradingApp')
  end

  def broker_approved(user)
    @user = user
    mail(to: @user.email, subject: 'Broker account approved')
  end
end


