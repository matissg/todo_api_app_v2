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

    if resource_with_tag.save
      render jsonapi: resource_with_tag.record, include: :tags, status: :created
    else
      render_errors
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /posts/1
  def update
    resource_params

    if resource_with_tag.save
      render jsonapi: resource_with_tag.record, include: :tags
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

  def resource_with_tag
    @resource_with_tag ||= "#{resource_class}WithTag".constantize.new(resource_class)
  end

  def resource_params
    resource_with_tag.params = params.require(:data)
                                     .require(:attributes)
                                     .permit(allowed_params)
                                     .merge(id: params[:id])
  end

  def allowed_params
    allowed_params_base
  end

  def allowed_params_base
    [:title, { tags: [] }]
  end

  def render_all_records
    render jsonapi: resource_class.all.includes(:tags), include: :tags
  end

  def render_record
    render jsonapi: record
  end

  def record
    @record ||= resource_class.find(params[:id])
  end

  def render_errors
    render jsonapi_errors: resource_with_tag.errors, status: :unprocessable_entity
  end
end
