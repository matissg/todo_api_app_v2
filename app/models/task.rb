class Task < ApplicationRecord
  include WithTaggable

  validates :title, length: { in: 3..500, message: I18n.t(:characters_allowed, min: 3, max: 500) }, presence: true
end
