require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject(:object) { create(:tag) }

  describe 'associations' do
    it { is_expected.to have_many(:tasks).through(:taggings) }
  end

  it { is_expected.to validate_uniqueness_of(:title) }
  include_examples 'a title validation', 101
end
