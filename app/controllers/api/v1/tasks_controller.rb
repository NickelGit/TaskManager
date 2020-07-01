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
      includes([:author, :assignee])
    respond_with(tasks, each_serializer: TaskSerializer, root: 'items', meta: build_meta(tasks))
  end

  def new; end

  def create
    task = current_user.my_tasks.new(task_params)
    task.author = current_user

    if task.save
      SendTaskCreateNotificationJob.perform_async(task.id)
    end

    respond_with(task, serializer: TaskSerializer, location: nil)
  end

  def update
    task = Task.find(params[:id])
    if task.update(task_params)
      SendTaskUpdateNotificationJob.perform_async(task.id)
    end

    respond_with(task, serializer: TaskSerializer)
  end

  def destroy
    task = Task.find(params[:id])
    if task.destroy
      SendTaskDeleteNotificationJob.perform_async(task.author_id, task.assignee_id, task.id, task.name, task.description)
    end

    respond_with(task)
  end

  def attach_image
    task = Task.find(params[:id])
    task_attach_image_form = TaskAttachImageForm.new(attachment_params)
  
    if task_attach_image_form.invalid?
      respond_with task_attach_image_form
      return
    end
  
    image = task_attach_image_form.processed_image
    task.image.attach(image)
  
    respond_with(task, serializer: TaskSerializer)
  end
  
  def remove_image
    task = Task.find(params[:id])
    task.image.purge
  
    respond_with(task, serializer: TaskSerializer)
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :author_id, :assignee_id, :state_event, :expired_at)
  end
end
