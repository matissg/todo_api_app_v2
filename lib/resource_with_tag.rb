class ResourceWithTag
  include ActiveModel::Validations
  attr_reader :resource, :params, :record

  def initialize(resource)
    @resource = resource
  end

  def params=(params)
    @params = params || {}
  end

  def save
    tags_titles_validation
    return false if errors.any?

    ActiveRecord::Base.transaction do
      @record = prepare_resource

      true
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::Rollback => e
    errors.add(:base, e.message)
    false
  end

  private

  def tags
    @tags ||= params[:tags]
  end

  def prepare_resource
    id = params[:id]
    item = id.nil? ? resource.new : resource.find_by(id: id)
    return add_error(:not_found) unless item

    item.assign_attributes(resource_attributes.merge(tags: add_tags))
    item.save!
    item
  end

  def add_tags
    existing_tags = Tag.where(title: sanitized_unique_tags)
    creatable_tags = sanitized_unique_tags - existing_tags.map(&:title)
    new_tags = creatable_tags.map { |tag_title| Tag.create!(title: tag_title) }

    existing_tags + new_tags
  end

  def sanitized_unique_tags
    @sanitized_unique_tags ||= tags.map { |tag| tag.tr('#@', '') }.uniq.reject(&:empty?)
  end

  def tags_titles_validation
    return if tags.blank?

    if tags.size > 30
      errors.add(:tags, :too_many_tags)
    elsif !tags.is_a?(Array)
      errors.add(:tags, :wrong_tags)
    end
  end

  def add_error(reason)
    errors.add(:base, reason)
    raise ActiveRecord::Rollback
  end
end
