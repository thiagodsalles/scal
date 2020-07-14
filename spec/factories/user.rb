FactoryBot.define do
  factory :user do
    name { 'user-name' }
    email { 'mail@mail.com' }
    password { '123456' }
  end
end
