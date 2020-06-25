class SendTaskUpdateNotificationJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_throttle_as :mailer
  sidekiq_options lock: :until_and_while_executing, on_conflict: { client: :log, server: :reject }

  def perform(task_id)
    return if task_id.blank?

    UserMailer.with(task_id: task_id).task_updated.deliver_now
  end
end
