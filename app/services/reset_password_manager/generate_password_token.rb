module ResetPasswordManager
  class GeneratePasswordToken < ApplicationService
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def call
      @user.reset_password_token = generate_token
      @user.reset_password_sent_at = Time.current
      @user.save!
    end

    def generate_token
      token = SecureRandom.hex(10)
      token = generate_token if User.exists?(reset_password_token: token)
      token
    end
  end
end
