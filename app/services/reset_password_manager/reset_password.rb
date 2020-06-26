module ResetPasswordManager
  class ResetPassword < ApplicationService
    attr_reader :user

    def initialize(user, password)
      @user = user
      @password = password
    end

    def call
      @user.reset_password_token = nil
      @user.password = @password
      @user.save!
    end
  end
end
