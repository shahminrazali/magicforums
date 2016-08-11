class PasswordResetsMailer < ApplicationMailer

  def password_reset_mail(user)
    @user = user
    # @url = "#{ENV.fetch('SERVER_URL')}/password_resets/#{@user.password_reset_token}/edit"
    @url = "http://localhost:3000/password_resets/#{@user.password_reset_token}/edit"
    mail(to: @user.email, subject: "Your password has been reset")
  end
end
