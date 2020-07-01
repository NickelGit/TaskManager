class SendPasswordResetNotificationJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_throttle_as :mailer

  def perform(user_id, url)
    user = User.find(user_id)

    UserMailer.with(user: user, url: url).reset_password.deliver_later
  end
end
