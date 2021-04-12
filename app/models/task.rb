class Task < ApplicationRecord
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, length: { in: 3..500, message: '3 to 500 characters allowed' }, presence: true
end
