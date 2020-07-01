module ResetPasswordManager
  class PasswordTokenValidation < ApplicationService
    attr_reader :user

    DAY = 24.hours

    def initialize(user)
      @user = user
    end

    def call
      (user.reset_password_sent_at + DAY) > Time.current
    end
  end
end
