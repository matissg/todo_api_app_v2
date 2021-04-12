class Api::V1::ResourceWithTagsController < ApplicationController
  # GET /tasks
  # GET /posts
  def index
    render_all_records
  end

  # GET /tasks/1
  # GET /posts/1
  def show
    render_record
  end

  # POST /tasks
  # POST /posts
  def create
    resource_params

    if resource.save
      render jsonapi: resource.record, include: :tags, status: :created
    else
      render_errors
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /posts/1
  def update
    resource_params

    if resource.save
      render jsonapi: resource.record, include: :tags
    else
      render_errors
    end
  end

  # DELETE /tasks/1
  # DELETE /posts/1
  def destroy
    record&.destroy
  end

  private

  def resource
    @resource ||= ResourceWithTag.new(resource_klass)
  end

  def resource_params
    resource.params = params.require(:data).require(:attributes).permit(allowed_params_base).merge(id: params[:id])
  end

  def allowed_params_base
    [:title, { tags: [] }]
  end

  def render_all_records
    render jsonapi: resource_klass.all.includes(taggings: :tag), include: :tags
  end

  def render_record
    render jsonapi: record
  end

  def record
    @record ||= resource_klass.find(params[:id])
  end

  def render_errors
    render jsonapi_errors: resource.errors, status: :unprocessable_entity
  end
end
