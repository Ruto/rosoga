json.user do
  json.call(
    @user,
    :email,
    :username,
    :phone,
    :phone_confirmed,
    :email_confirmed,
    :confirmation_sent_at,
    :user_confirmed
  )
  json.token token
end
