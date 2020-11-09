class UserMailer < ApplicationMailer
  default from: "smartbizapp@gmail.com"
 # prepend_view_path "custom/path/to/mailer/view"
  #layout 'user_mailer/user_confirmation.text.erb' # use awesome.(html|text).erb as the layout
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.user_confirmation.subject
  #
  def user_confirmation
    #@greeting = "Hi"
    @user = params[:user]
    mail to: @user.email, subject: 'New SmartBiz Account Confirmation'

  end

  def forgot_password(user)
    @user = user
    @greeting = "Hi"

    mail to: user.email, :subject => 'Reset password instructions'
  end

end
