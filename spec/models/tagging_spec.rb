require 'rails_helper'

RSpec.describe Tagging, type: :model do
  subject(:object) { create(:tagging) }

  describe 'associations' do
    it { is_expected.to belong_to(:taggable) }
    it { is_expected.to belong_to(:tag) }
  end
end
