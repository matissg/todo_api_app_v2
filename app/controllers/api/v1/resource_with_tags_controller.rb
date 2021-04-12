class Api::V1::ResourceWithTagsController < ApplicationController
  # POST /tasks
  def create
    resource_params

    if resource.save
      render jsonapi: resource.record, include: :tags, status: :created
    else
      render_errors
    end
  end

  # PATCH/PUT /tasks/1
  def update
    resource_params

    if resource.save
      render jsonapi: resource.record, include: :tags
    else
      render_errors
    end
  end

  private

  def resource
    @resource ||= ResourceWithTag.new(Task)
  end

  def resource_params
    resource.params = allowed_params.merge(id: params[:id])
  end

  def allowed_params
    params.require(:data).require(:attributes).permit(:title, tags: [])
  end

  def render_errors
    render jsonapi_errors: resource.errors, status: :unprocessable_entity
  end
end
