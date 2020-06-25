class SendPasswordResetNotificationJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_throttle_as :mailer

  def perform(user_id, url)
    return if user_id.blank? || url.blank?

    UserMailer.with(user_id: user.id, url: root_url).reset_password.deliver_later
  end
end
