FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password '12345678'
    password_confirmation '12345678'
    auth_token 'a1'
  end
end
