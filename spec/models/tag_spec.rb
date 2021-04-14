require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject(:object) { create(:tag) }

  describe 'associations' do
    it { is_expected.to have_many(:tasks).through(:taggings) }
  end

  it { is_expected.to validate_uniqueness_of(:title) }
  include_examples 'a title validation', 101
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
