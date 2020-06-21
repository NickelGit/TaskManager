module ResetPasswordHelper
  extend ActiveSupport::Concern
  def generate_password_token!(user)
    user.reset_password_token = generate_token
    user.reset_password_sent_at = Time.now.utc
    user.save!
  end

  def password_token_valid?(user)
    (user.reset_password_sent_at + 24.hours) > Time.now.utc
  end

  def reset_password!(user, password)
    user.reset_password_token = nil
    user.password = password
    user.save!
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
