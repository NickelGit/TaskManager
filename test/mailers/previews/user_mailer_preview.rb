# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def task_created
    task = Task.first
    params = { task_id: task.id }

    UserMailer.with(params).task_created
  end

  def task_updated
    task = Task.first
    params = { task_id: task.id }

    UserMailer.with(params).task_updated
  end

  def task_deleted
    task = Task.first
    params = { author_id: task.author_id,
               assignee_id: task.assignee_id,
               task_id: task.id,
               task_name: task.name,
               task_description: task.description }

    UserMailer.with(params).task_deleted
  end
end
