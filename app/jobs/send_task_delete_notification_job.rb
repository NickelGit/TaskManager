class SendTaskDeleteNotificationJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_throttle_as :mailer

  def perform(author_id, assignee_id, task_id, task_name, task_description)
    UserMailer.with({ author_id: author_id,
                      assignee_id: assignee_id,
                      task_id: task_id,
                      task_name: task_name,
                      task_description:
      task_description }).task_deleted.deliver_now
  end
end
