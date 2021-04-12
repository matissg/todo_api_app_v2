FactoryBot.define do
  factory :tagging, class: 'Tagging' do
    association :taggable, factory: :task
    association :tag
  end
end
