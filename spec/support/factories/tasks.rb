FactoryBot.define do
  factory :task, class: 'Task' do
    sequence(:title) { |n| "#{n}_task" }
  end
end
