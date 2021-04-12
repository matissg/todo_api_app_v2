class Api::V1::PostsController < Api::V1::ResourceWithTagsController
  private

  def resource_klass
    Post
  end

  def allowed_params
    allowed_params.concat(:content)
  end
end
