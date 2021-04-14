class Api::V1::PostsController < Api::V1::ResourceWithTagsController
  private

  def resource_class
    Post
  end

  def allowed_params
    allowed_params_base << :content
  end
end
