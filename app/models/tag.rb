class Tag < ApplicationRecord
  has_many :taggings, as: :taggable
  has_many :tasks, through: :taggings, source: :taggable, source_type: 'Task'

  validates :title, length: { in: 3..100, message: '3 to 100 characters allowed' }, presence: true, uniqueness: true
end
