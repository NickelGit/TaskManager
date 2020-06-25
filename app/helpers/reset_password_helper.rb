module ResetPasswordHelper
  DAY = 24.hours
  
  def generate_password_token!(user)
    user.reset_password_token = generate_token
    user.reset_password_sent_at = Time.current
    user.save!
  end

  def password_token_valid?(user)
    (user.reset_password_sent_at + DAY) > Time.current
  end

  def reset_password!(user, password)
    user.reset_password_token = nil
    user.password = password
    user.save!
  end

  private

  def generate_token
    token = SecureRandom.hex(10)
    token = generate_token if User.exists?(reset_password_token: token) 
    token   
  end
end
