class Task < ApplicationRecord
  include WithTaggable

  validates :title, length: { in: 3..500, message: I18n.t(:characters_allowed, min: 3, max: 500) }, presence: true
end

# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  title      :string(500)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
