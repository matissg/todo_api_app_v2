require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:object) { create(:post) }

  describe 'associations' do
    it { is_expected.to have_many(:tags).through(:taggings) }
  end

  include_examples 'a title validation', 501
end
