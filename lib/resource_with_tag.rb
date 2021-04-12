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
      tags.blank? ? remove_tags : add_tags

      true
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::Rollback => e
    errors.add(:base, e.message)
    false
  end

  private

  def title
    @title ||= params[:title]
  end

  def tags
    @tags ||= params[:tags]
  end

  def prepare_resource
    id = params[:id]
    item = id.nil? ? resource.new : resource.find_by(id: id)
    return add_error(:not_found) unless item

    item.title = title
    item.save!
    item
  end

  def add_tags
    record.tags = sanitized_unique_tags.map { |tag_title| Tag.where(title: tag_title).first_or_create! }.compact
  end

  def remove_tags
    record.taggings&.destroy_all
  end

  def sanitized_unique_tags
    @sanitized_unique_tags ||= tags.map { |tag| tag.tr('#', '').tr('@', '') }.uniq.reject(&:empty?)
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
