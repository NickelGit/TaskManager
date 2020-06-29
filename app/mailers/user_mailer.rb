class UserMailer < ApplicationMailer
  default from: 'noreply@taskmanager.com'
  def task_created
    @task = params[:task]

    mail(to: @task.author.email, subject: 'New Task Created')
  end

  def task_updated
    @task = params[:task]

    if @task.assignee.nil?
      mail(to: @task.author.email, subject: 'Task Updated')
    else
      mail(to: [@task.author.email, @task.assignee.email], subject: 'Task Updated')
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

  def reset_password
    @user = params[:user]
    @url = params[:url]

    mail(to: @user.email, subject: 'Reset password')
  end
end
