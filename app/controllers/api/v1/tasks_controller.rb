class Api::V1::TasksController < Api::V1::ResourceWithTagsController
  # GET /tasks
  def index
    render jsonapi: Task.all.includes(taggings: :tag), include: :tags
  end

  # GET /tasks/1
  def show
    render jsonapi: task
  end

  # DELETE /tasks/1
  def destroy
    task&.destroy
  end

  private

  def task
    @task ||= Task.find(params[:id])
  end
end
