class User < ApplicationRecord
  has_secure_password

  validates :email, :username, :phone, presence: true, on: :create
  validates :email, :username, :phone, :phone_token, :email_token, uniqueness: true
  validates :email, case_sensitive: false
  #validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }

  before_save :downcase_email
  before_create :generate_confirmation_instructions


  def downcase_email
    self.email = self.email.delete(' ').downcase
  end

  def generate_confirmation_instructions
    self.phone_token = SecureRandom.hex(3).upcase
    self.phone_token_sent_at = Time.now.utc
    self.email_token = SecureRandom.hex(3).upcase
    self.email_token_sent_at = Time.now.utc
    self.confirmation_sent_at = Time.now.utc
  end

  def confirmation_token_valid?
    (self.confirmation_sent_at + 14.days) > Time.now.utc
  end

  def reset_email_token!
    self.email_token = SecureRandom.hex(3).upcase
    self.email_token_sent_at = Time.now.utc
    save
  end

  def reset_phone_token!
    self.phone_token = SecureRandom.hex(3).upcase
    self.phone_token_sent_at = Time.now.utc
    save
  end

  def mark_as_email_confirmed!
    self.email_token = nil
    self.email_confirmed = true
    self.email_confirmed_at = Time.now.utc
    self.user_confirmed = true
    save
  end

  def mark_as_phone_confirmed!
    self.phone_token = nil
    self.phone_confirmed = true
    self.phone_confirmed_at = Time.now.utc
    self.user_confirmed = true
    save
  end

  def send_password_reset_token
    generate_token(:reset_password_token)
    self.reset_password_sent_at = Time.zone.now
    self.reset_password_expires_at = Time.zone.now + 2.hours
    self.forgot_password = true
    self.reset_password_count += 1
    save!
    UserMailer.forgot_password(self).deliver# This sends an e-mail with a link for the user to reset the password
  end

  def empty_token_and_expiry!
    self.forgot_password = false
    self.reset_password_token = nil
    self.reset_password_expires_at = nil
    save
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64(5)
    end while User.exists?(column => self[column])
  end

end
