class Api::V1::TasksController < Api::V1::ApplicationController
  def show
    task = Task.find(params[:id])

    respond_with(task, serializer: TaskSerializer)
  end

  def index
    tasks = Task.
      order(updated_at: :desc).
      ransack(ransack_params).
      result.
      page(page).
      per(per_page).
      includes([:author]).
      includes([:assignee])
    respond_with(tasks, each_serializer: TaskSerializer, root: 'items', meta: build_meta(tasks))
  end

  def new; end

  def create
    task = current_user.my_tasks.new(task_params)
    task.author = current_user

    if task.save
      UserMailer.with({ user: current_user, task: task }).task_created.deliver_now
    end

    respond_with(task, serializer: TaskSerializer, location: nil)
  end

  def update
    task = Task.find(params[:id])
    if task.update(task_params)
      UserMailer.with({ user: task.author, task: task }).task_updated.deliver_now
    end

    respond_with(task, serializer: TaskSerializer)
  end

  def destroy
    task = Task.find(params[:id])
    if task.destroy
      UserMailer.with({ user: task.author, task: task }).task_deleted.deliver_now
    end

    respond_with(task)
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :author_id, :assignee_id, :state_event, :expired_at)
  end
end
