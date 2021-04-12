RSpec.shared_examples_for 'a title validation' do |max_number|
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }

    it 'updates object title' do
      object.update(title: 'New Title')
      expect(object).to be_valid
    end

    it 'is not valid without a title' do
      object.title = nil
      expect(object).to_not be_valid
    end

    it 'is not valid with too short title' do
      object.title = 'aa'
      expect(object).to_not be_valid
    end

    it 'is not valid with too long title' do
      object.title = 'a' * max_number
      expect(object).to_not be_valid
    end
  end
end
