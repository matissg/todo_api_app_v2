require 'rails_helper'

RSpec.describe Task, type: :model do
  subject(:object) { create(:task) }

  describe 'associations' do
    it { is_expected.to have_many(:tags).through(:taggings) }
  end

  include_examples 'a title validation', 501
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
