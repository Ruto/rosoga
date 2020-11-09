json.user do
  json.call(
    @user,
    :email,
    :forgot_password,
    :reset_password_expires_at,
    :phone_confirmed,
    :phone_token_sent_at,
    :email_confirmed,
    :email_token_sent_at,
    :confirmation_sent_at,
    :user_confirmed
  )
end
