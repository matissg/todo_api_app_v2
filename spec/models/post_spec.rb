require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:object) { create(:post) }

  describe 'associations' do
    it { is_expected.to have_many(:tags).through(:taggings) }
  end

  include_examples 'a title validation', 501
end

# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :text(5000)
#  title      :string(500)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
