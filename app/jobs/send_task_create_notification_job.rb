class SendTaskCreateNotificationJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_throttle_as :mailer

  def perform(task_id)
    task = Task.find(task_id)

    UserMailer.with(task: task).task_created.deliver_now
  end
end
