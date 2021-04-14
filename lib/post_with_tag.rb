class PostWithTag < ResourceWithTag
  include ActiveModel::Validations

  private

  def resource_attributes
    { title: params[:title], content: params[:content] }
  end
end
