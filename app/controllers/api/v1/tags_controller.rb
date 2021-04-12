class Api::V1::TagsController < ApplicationController
  # GET /tags
  def index
    render jsonapi: Tag.all
  end

  # POST /tags
  def create
    tag = Tag.new(allowed_params)

    if tag.save
      render jsonapi: tag, status: :created
    else
      render_errors(tag)
    end
  end

  # PATCH/PUT /tags/1
  def update
    tag = Tag.find(params[:id])

    if tag.update(allowed_params)
      render jsonapi: tag
    else
      render_errors(tag)
    end
  end

  private

  def allowed_params
    params.require(:data).require(:attributes).permit(:id, :title)
  end

  def render_errors(tag)
    render jsonapi_errors: tag.errors, status: :unprocessable_entity
  end
end
