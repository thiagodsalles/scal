FactoryBot.define do
  factory :notice do
    title { 'notice-title' }
    text { 'notice-text' }
    association :category
    association :user
  end
end
