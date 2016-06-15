FactoryGirl.define do
  factory :wish do
    wish_text {FFaker::Lorem.phrase}
    outcome_text {FFaker::Lorem.sentence}
    user_id 1
  end
end
