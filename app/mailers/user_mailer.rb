class UserMailer < ApplicationMailer
  default subject: 'Welcome to Odinbook'

  def welcome_mail
    @user = params[:user]
    @url = root_url
    mail(to: @user.email)
  end

end
