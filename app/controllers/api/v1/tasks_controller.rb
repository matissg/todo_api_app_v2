class Api::V1::TasksController < Api::V1::ResourceWithTagsController
  private

  def resource_class
    Task
  end
end
