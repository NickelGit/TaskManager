class UserMailer < ApplicationMailer
  default from: 'noreply@taskmanager.com'
  def task_created
    @task = Task.find(params[:task_id])
    author = @task.author

    mail(to: author.email, subject: 'New Task Created')
  end

  def task_updated
    @task = Task.find(params[:task_id])
    author = @task.author

    if @task.assignee.nil?
      mail(to: author.email, subject: 'Task Updated')
    else
      assignee = @task.assignee

      mail(to: [author.email, assignee.email], subject: 'Task Updated')
    end
  end

  def task_deleted
    @task_id = params[:task_id]
    @task_name = params[:task_name]
    @task_description = params[:task_description]
    author = User.find(params[:author_id])

    if params[:assignee_id].nil?
      mail(to: author.email, subject: 'Task Deleted')
    else
      assignee = User.find(params[:assignee_id])

      mail(to: [author.email, assignee.email], subject: 'Task Deleted')
    end
  end
end
