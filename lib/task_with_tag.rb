class TaskWithTag < ResourceWithTag
  include ActiveModel::Validations

  private

  def resource_attributes
    { title: params[:title] }
  end
end
