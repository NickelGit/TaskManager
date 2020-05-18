class Api::V1::TasksController < Api::V1::ApplicationController
  respond_to :json

  def show; end

  def index
    tasks = Task.all.
      ransack(ransack_params).
      result.
      page(page).
      per(per_page)
    respond_with(tasks, each_serializer: TaskSerializer, root: 'items', meta: build_meta(tasks))
  end

  def new; end

  def create; end

  def update; end

  def destroy; end

  private

  def task_params; end
end
