FactoryBot.define do
  factory :tag, class: 'Tag' do
    sequence(:title) { |n| "#{n}_tag" }
  end
end
