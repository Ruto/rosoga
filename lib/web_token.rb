class WebToken
    SECRET = Rails.env.production? ? ENV['SECRET_KEY_BASE'] : Rails.application.secrets.secret_key_base
    # EXPIRY = (Time.now + 1.day).to_i

    def self.expiry(device)
      if device == "Android"
        return (Time.now + 30.days).to_i
      elsif device == "IOS"
        return (Time.now + 30.days).to_i
      else
        return (Time.now + 30.days).to_i
      end
    end

    def self.decode(token)
      JWT.decode(
        token,
        WebToken::SECRET,
        true, { algorithm: 'HS256' }
      ).first
    rescue JWT::ExpiredSignature
      :expired
      #implement reset token action if reset conditions met
    end

    def self.encode(user, device)
      JWT.encode(
        token_params(user, device),
        WebToken::SECRET,
        'HS256'
      )
    end

    def self.valid_payload(payload)
       if expired(payload) # || payload['iss'] != meta[:iss] || payload['aud'] != meta[:aud]
         return false
       else
         return true
       end
     end

    private

    def self.expired(payload)
       Time.at(payload['exp']) < Time.now
    end

    def self.token_params(user, device)
      {
        user_id: user.id,
        exp: expiry(device),
        name: user.username,
        email: user.email
      }
    end
  end
