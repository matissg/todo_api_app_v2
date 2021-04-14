class Tag < ApplicationRecord
  has_many :taggings, as: :taggable
  has_many :tasks, through: :taggings, source: :taggable, source_type: 'Task'

  validates :title,
            length: { in: 3..100, message: I18n.t(:characters_allowed, min: 3, max: 100) },
            presence: true,
            uniqueness: true
end

# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  title      :string(100)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_title  (title) UNIQUE
#
