class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :phone, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :active, default: true
      t.string  :device
      t.text    :device_desc

      #phone confirmations
      t.string   :phone_token
      t.boolean  :phone_confirmed, default: false
      t.datetime :phone_token_sent_at
      t.datetime :phone_confirmed_at

      #email confirmations
      t.string   :email_token
      t.boolean  :email_confirmed, default: false
      t.datetime :email_token_sent_at
      t.datetime :email_confirmed_at

      #token confirmations sent at time
      t.datetime :confirmation_sent_at
      t.boolean  :user_confirmed, default: false

      # confirmation_token
      #t.string   :confirmation_token
      #t.datetime :confirmed_at
      #t.datetime :confirmation_sent_at
      #t.datetime :confirmation_time_at

      # Recoverable
      t.boolean  :forgot_password, default: false
      t.datetime :reset_password_expires_at
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :reset_password_reset_at
      t.integer  :reset_password_count, default: 0

      #Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at
      t.datetime :unlocked_time


      t.timestamps
    end
    add_index :users, :username,             unique: true
    add_index :users, :phone,                unique: true
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :phone_token,          unique: true
    add_index :users, :email_token,          unique: true
    add_index :users, :unlock_token,         unique: true
  end
end
