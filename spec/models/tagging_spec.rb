require 'rails_helper'

RSpec.describe Tagging, type: :model do
  subject(:object) { create(:tagging) }

  describe 'associations' do
    it { is_expected.to belong_to(:taggable) }
    it { is_expected.to belong_to(:tag) }
  end
end

# == Schema Information
#
# Table name: taggings
#
#  id            :integer          not null, primary key
#  taggable_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  tag_id        :bigint           not null
#  taggable_id   :bigint           not null
#
# Indexes
#
#  index_taggings_on_taggable_id_and_taggable_type_and_tag_id  (taggable_id,taggable_type,tag_id) UNIQUE
#
# Foreign Keys
#
#  tag_id  (tag_id => tags.id)
#
