class Post < ApplicationRecord
  include WithTaggable

  validates :title, length: { in: 3..500, message: I18n.t(:characters_allowed, min: 3, max: 500) }, presence: true
  validates :content, length: { in: 3..5000, message: I18n.t(:characters_allowed, min: 3, max: 5000) }, allow_blank: true
end
