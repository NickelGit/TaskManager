class SendTaskCreateNotificationJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_throttle_as :mailer

  def perform(task_id)
    return if task_id.blank?

    UserMailer.with(task_id: task_id).task_created.deliver_now
  end
end