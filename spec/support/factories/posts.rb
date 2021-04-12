FactoryBot.define do
  factory :post, class: 'Post' do
    sequence(:title) { |n| "#{n}_post" }
    sequence(:content) { 'some content' }
  end
end
